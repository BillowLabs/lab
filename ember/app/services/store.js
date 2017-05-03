import Ember from 'ember'
import DS from 'ember-data'

export default DS.Store.extend({

	init() {
		if (window.parent.connect_SFDC) this.hostedOnSalesforce = true
		return this._super.apply(this, arguments)
	},

	adapterFor(modelName) {
		if (!this.hostedOnSalesforce) return new DS.RESTAdapter()
		return this._super(modelName)
	}

})
