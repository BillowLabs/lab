import Ember from 'ember'
import DS from 'ember-data'

let sfconn = null

export default DS.RESTAdapter.extend (
	{ shouldReloadAll: shouldReloadAll
	, init: init
	, findRecord: findRecord
	, findAll: findAll
	, createRecord: createRecord
	, updateRecord: updateRecord
	, deleteRecord: deleteRecord
	, query: query
	}
)


function shouldReloadAll (store, snapshot) {
	return store.peekAll(snapshot.type.modelName).get("length") <= 0
}


function init () {
	this._super(...arguments)

	console.log('Connecting to SFDC...')
	sfconn = window.parent.connect_SFDC()
}


function findRecord (store, type, id) {

	var sfObj = getSfObject.call(this, type.modelName)

	return new Ember.RSVP.Promise((resolve, reject) => {
		return sfObj.retrieve({
			where: {
				Id: { eq: id }
			},
			limit: 100
		}, function(err, data){
			if (err) {
				reject(err)
			} else {
				var result = {}
				result[type.modelName] = convertToModel(data[0])
				resolve(result)
			}
		})
	})

}


function findAll (store, type, sinceToken) {
	var inflector = new Ember.Inflector()
	var sfObj = getSfObject.call(this, type.modelName)

	return new Ember.RSVP.Promise((resolve, reject) => {
		return sfObj.retrieve({
			limit: 100
		}, function(err, data){
			if (err) {
				reject(err)
			} else {
				var result = {}
				result[inflector.pluralize(type.modelName)] = data.map(a => convertToModel(a))
				resolve(result)
			}
		})
	})
}


function createRecord (store, type, snapshot) {
	console.log('Attempting to create ' + type.modelName)

	var model = this.serialize(snapshot, {includeId: false})
	var sfObj = getSfObject.call(this, type.modelName)

	return new Ember.RSVP.Promise((resolve, reject) => {
		return sfObj.create(convertToRemoteData(sfObj, model), function(err, data){
			if (err) {
				reject(err)
			} else {
				// TODO: fix this ref to a private var with the correct prop
				store.updateId(snapshot._internalModel, {id:  data[0]})
				console.log('CREATED', snapshot._internalModel)
				resolve(snapshot._internalModel)
			}
		})
	})

}


function updateRecord (store, type, snapshot) {
	console.log('Attempting to update ' + type.modelName)

	var model = this.serialize(snapshot, {includeId: true})
	var id = model.id
	delete model.id
	console.log('USING', model)

	var sfObj = getSfObject.call(this, type.modelName)

	return new Ember.RSVP.Promise((resolve, reject) => {
		return sfObj.update([id], convertToRemoteData(sfObj, model), function(err, data){
			if (err) {
				reject(err)
			} else {
				console.log('UPDATED', data[0])
				resolve(model)
			}
		})
	})
}


function deleteRecord (store, type, snapshot) {
	console.log('Attempting to delete ' + type.modelName)

	var sfObj = getSfObject.call(this, type.modelName)

	var model = this.serialize(snapshot, {includeId: true})
	return new Ember.RSVP.Promise((resolve, reject) => {
		return sfObj.del([model.id], function(err, data){
			if (err) {
				reject(err)
			} else {
				console.log('DELETED', data[0])
				resolve(data[0])
			}
		})
	})
}

// For SF query options SEE:
// https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_remote_objects_using_retrieve_query_object.htm
function query (store, type, query) {

	var sfObj = getSfObject.call(this, type.modelName)
	var inflector = new Ember.Inflector()

	return new Ember.RSVP.Promise((resolve, reject) => {
		return sfObj.retrieve(query, function(err, data){
			if (err) {
				reject(err)
			} else {
				var result = {}
				result[inflector.pluralize(type.modelName)] = data.map(a => convertToModel(a))
				resolve(result)
			}
		})
	})
}


function getSfObject(name) {
	var func = sfconn[name]
	if (!func) return null

	return new func()
}


function convertToModel(obj) {
	if(!obj) return null

	var result = {
		id: obj.get('Id')
	}

	Object.keys(obj._fields).forEach(key => {
		var field = obj._fields[key]
		var name = field.shorthand || key
		var value = obj.get(key)

		if (value) value = he.decode(value)

		result[name] = value
	})

	return result
}


function convertToRemoteData(obj, model) {
	if(!obj || !model) return null

	var result = {
		Id: model['id']
	}

	Object.keys(obj._fields).forEach(key => {
		var field = obj._fields[key]
		var name = field.shorthand || key
		var value = model[name]

		result[key] = value
	})

	return result
}
