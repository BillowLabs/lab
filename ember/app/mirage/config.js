/*jshint ignore:start*/
import config from '../config/environment';

export default function() {

	this.timing = 0;
	
	this.get('/accounts', function(db, request) {
		return {
			"accounts": [{
				"id": 1,
				"name": 'Axe Capital'
			}]
		}
	})

	this.get('/accounts/:id', function(db, request) {
		return {
			"account": {
				"id": 1,
				"name": 'Axe Capital'
			}
		}
	})

}
/*jshint ignore:end*/
