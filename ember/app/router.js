import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
    location: config.locationType
});

Router.map(function() {
  // Index is handled by default
  this.route('launch', function() {
    this.route('steps');
    this.route('intro');
  });
  this.route('assess');
  this.route('build', function() {
    this.route('r');
    this.route('a');
    this.route('m');
  });
  this.route('style-guide');
  this.route('account', { path: '/accounts/:id' }, function() {});
  this.route('accounts', function() {});
});

export default Router;
