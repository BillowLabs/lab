import Ember from 'ember';
import DS from 'ember-data';
const { capitalize } = Ember.String;
const { camelize } = Ember.String;

// http://emberjs.com/api/data/classes/DS.RESTAdapter.html
// See: https://github.com/jheth/ember-force for more examples
var adapter = DS.RESTAdapter.extend({

	sfconn:null,

	shouldReloadAll: function() {
		return false;
	},

	init: function () {
		this._super(...arguments)

		console.log('Connecting to SFDC...')
		if (!window.parent.connect_SFDC) {
			console.log('Could not connect to salesforce. USING MOCK DATA')
			return;
		}
		this.sfconn = window.parent.connect_SFDC();
	},

	findRecord: function(store, type, id) {
		if (!this.sfconn) {
			return this._super(...arguments)
		}

		return new Ember.RSVP.Promise((resolve, reject) => {
			var obj = new this.sfconn[capitalize(type.modelName)]();
			return obj.retrieve({
				where: {
					Id: { eq: id }
				}
			}, function(err, data){
				if (err) {
					reject(err);
				} else {
					var result = {}
					result[type.modelName] = convertToJs(data[0])
					resolve(result);
				}
			})
		});

	},

	findAll: function(store, type, sinceToken) {
		if (!this.sfconn) {
			return this._super(...arguments)
		}

		return new Ember.RSVP.Promise((resolve, reject) => {
			var obj = new this.sfconn[capitalize(type.modelName)]();
			return obj.retrieve(function(err, data){
				if (err) {
					reject(err);
				} else {
					var result = {}
					result[type.modelName + 's'] = data.map(a => convertToJs(a))
					console.log(result)
					resolve(result);
				}
			})
		});
	},

	createRecord: function(store, type, snapshot) {
		console.log('Attempting to create ' + type.modelName)
		if (!this.sfconn) {
			return this._super(...arguments)
		}

		var model = this.serialize(snapshot, {includeId: false});
		return new Ember.RSVP.Promise((resolve, reject) => {
			var obj = new this.sfconn[capitalize(type.modelName)]();
			return obj.create(convertToSf(model), function(err, data){
				if (err) {
					reject(err);
				} else {
					// TODO: fix this ref to a private var with the correct prop
					store.updateId(snapshot._internalModel, {id:  data[0]});
					console.log('CREATED', snapshot._internalModel)
					resolve(snapshot._internalModel);
				}
			})
		});

	},


	updateRecord: function (store, type, snapshot) {
		console.log('Attempting to update ' + type.modelName)
		if (!this.sfconn) {
			return this._super(...arguments)
		}

		var model = this.serialize(snapshot, {includeId: true});
		var id = model.id
		delete model.id
		console.log('USING', model)

		return new Ember.RSVP.Promise((resolve, reject) => {
			var obj = new this.sfconn[capitalize(type.modelName)]();
			return obj.update([id], convertToSf(model), function(err, data){
				if (err) {
					reject(err);
				} else {
					console.log('UPDATED', data[0])
					resolve(model);
				}
			})
		});
	},


	deleteRecord: function (store, type, snapshot) {
		console.log('Attempting to delete ' + type.modelName)
		if (!this.sfconn) {
			return this._super(...arguments)
		}

		var model = this.serialize(snapshot, {includeId: true});
		return new Ember.RSVP.Promise((resolve, reject) => {
			var obj = new this.sfconn[capitalize(type.modelName)]();
			return obj.del([model.id], function(err, data){
				if (err) {
					reject(err);
				} else {
					console.log('DELETED', data[0])
					resolve(data[0]);
				}
			})
		});
	}

});





function convertToJs(data) {
	if(!data) {
		return null
	}

	var result = {}
	for(var prop in data._props) {
		result[camelize(prop)] = he.decode(data.get(prop))
	}
	return result
}


function convertToSf(data) {
	if(!data) {
		return null
	}

	var result = {}
	Object.getOwnPropertyNames(data).forEach(prop => {
		result[capitalize(prop)] = data[prop]
	})
	return result
}


export default adapter;
