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
					result[type.modelName] = convert(data[0])
					resolve(result);
				}
			})
		});

	},

	// findAll: function(store, type, sinceToken) {
	findAll: function() {
		return this._super(...arguments)
	},

	// createRecord: function(store, type, snapshot) {
	createRecord: function() {
		return this._super(...arguments)
	},

	// updateRecord: function (store, type, snapshot) {
	updateRecord: function () {
		return this._super(...arguments)
	},

	// deleteRecord: function (store, type, snapshot) {
	deleteRecord: function () {
		return this._super(...arguments)
	}

});

function convert(data) {
	if(!data) {
		return null
	}

	var result = {}
	for(var prop in data._props) {
		result[camelize(prop)] = data.get(prop)
	}
	return result
}


export default adapter;







// 	findAll: function(store, type, sinceToken) {
//
// 		var fields = ['Id'];
// 		type.eachAttribute(function(name, meta) {
// 			if (name !== 'attributes') {
// 				fields.push(name);
// 			}
// 		});
//
// 		type.eachRelationship(function(relationshipName, descriptor) {
// 			var kind = descriptor.kind;
// 			var relatedModel = store.modelFor(descriptor.type);
//
// 			/**
// 			 * belongsTo:
// 			 *
// 			 * SELECT Id, Name, Account.id, Account.Name FROM Opportunity WHERE Id = 'X'
// 			 */
// 			if (kind === "belongsTo") {
// 				fields.push(relationshipName + ".Id");
//
// 				relatedModel.eachAttribute(function(fname, meta) {
// 					var relatedField = relationshipName + "." + fname;
// 					if (fname !== 'attributes') {
// 						fields.push(relatedField);
// 					}
// 				});
//
// 			} else if (kind === "hasMany") {
// 				/**
// 				 * hasMany:
// 				 *
// 				 * SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = 'X'
// 				 */
// 				var subquery_fields = [];
// 				subquery_fields.push("Id");
// 				relatedModel.eachAttribute(function(fname, meta) {
// 					if (fname !== 'attributes') {
// 						subquery_fields.push(fname);
// 					}
// 				});
// 				var subquery = '(SELECT ' + subquery_fields.join(', ') + " FROM " + relationshipName + ')';
// 				fields.push(subquery);
// 			}
// 		});
//
// 		return new Ember.RSVP.Promise((resolve, reject) => {
//
// 			var soql = "SELECT " + fields.join(', ') + " FROM " + capitalize(type.modelName);
// 			console.log(soql);
// 			return this.sfconn.query(soql, function(err, result) {
// 				if (err) {
// 					console.log(err);
// 					reject(result);
// 					return;
// 				}
//
// 				console.log("total : ", result.totalSize);
// 				console.log("fetched : ", result.records.length);
// 				console.log("done ? : ", result.done);
// 				if (!result.done) {
// 					// you can use the locator to fetch next records set.
// 					// Connection#queryMore()
// 					console.log("next records URL : ", result.nextRecordsUrl);
// 				}
//
// 				resolve(result.records);
// 			});
// 		});
// 	},



// 	createRecord: function(store, type, snapshot) {
// 		// var data = {};
// 		// var serializer = store.serializerFor(type.modelName);
// 		// serializer.serializeIntoHash(data, type, record, { includeId: true });
//
// 		var data = this.serialize(snapshot, { includeId: true });
//
// 		console.log("Create : ", type, " with ", data);
//
// 		return new Ember.RSVP.Promise((resolve, reject) => {
// 			// Single record creation
// 			this.sfconn.sobject(capitalize(type.modelName)).create(data, function(err, ret) {
// 				if (err || !ret.success) {
// 					console.log(err, ret);
// 					reject(ret);
// 				} else {
// 					console.log("Created record id : ", ret.id);
// 					// ...
// 					if (ret.success === true) {
// 						console.log('resolve', ret);
// 						resolve(ret);
// 					}
// 				}
// 			});
// 		});
// 	},



// 	updateRecord: function (store, type, snapshot) {
// 		//var data = {};
// 		//var serializer = store.serializerFor(type.modelName);
// 		//serializer.serializeIntoHash(data, type, record, { includeId: true });
// 		var data = this.serialize(snapshot, { includeId: true });
//
// 		return new Ember.RSVP.Promise((resolve, reject) => {
// 			// Single record update
// 			this.sfconn.sobject(type.modelName).update(data, function(err, ret) {
// 				if (err || !ret.success) {
// 					console.log(err, ret);
// 					reject(ret);
// 				} else {
// 					console.log('Updated Successfully : ', ret);
// 					if (ret.success === true && ret.errors.length === 0) {
// 						resolve(ret);
// 					}
// 				}
// 			});
//
// 		});
// 	},



// 	deleteRecord: function (store, type, snapshot) {
// 		var id = snapshot.id;
// 		console.log('Delete ', type, id);
//
// 		return new Ember.RSVP.Promise((resolve, reject) => {
// 			// Single record deletion
// 			return this.sfconn.sobject(type.modelName).destroy(id, function(err, ret) {
// 				if (err || !ret.success) {
// 					console.log(err, ret);
// 					reject(err);
// 				} else if (ret.success === true) {
// 					console.log('Deleted Successfully : ', ret);
// 					resolve(ret);
// 				}
// 			});
// 		});
// 	}
