import Ember from 'ember';
import PropertyWatcherMixin from './property-watcher';
import { module, test } from 'qunit';

module('Unit | Mixin | property watcher');

// Replace this with your real tests.
test('it works', function(assert) {
  var PropertyWatcherObject = Ember.Object.extend(PropertyWatcherMixin);
  var subject = PropertyWatcherObject.create();
  assert.ok(subject);
});
