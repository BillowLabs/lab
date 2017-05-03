import Ember from 'ember';

export default Ember.Route.extend({
	model() {
		return this.store.findAll('account');
	}
	, actions: {
		createNewTestAccount() {
			var account = this.store.createRecord('account', {
				name: 'Test One Two Three'
			})
			return account.save();
		}
		,deleteAccount(account) {
			return account.destroyRecord();
		}
		,renameAccount(account) {
			account.set('name', 'I\'m Renamed')
			return account.save();
		}
	}
});
