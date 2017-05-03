/*jshint ignore:start*/
import config from '../config/environment';

export default function() {

	this.timing = 0;

	this.get('/accounts')

	this.get('/accounts/:id')

	this.post('/accounts')

	this.delete('/accounts/:id')

	this.put('/accounts/:id')


}
/*jshint ignore:end*/
