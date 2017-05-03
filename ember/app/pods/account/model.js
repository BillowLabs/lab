import DS from 'ember-data';

export default DS.Model.extend({
	name: DS.attr(),
	active: DS.attr()
});
