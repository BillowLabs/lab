/*jshint node:true*/
/* global require, module */
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

// Adding the following to watch less files in the pod structure
// TODO: remove this once ember-cli learns to watch less files in a pod structure
var mergeTrees = require('broccoli-merge-trees');
var Funnel = require('broccoli-funnel');
var unwatchedTree = require('broccoli-unwatched-tree');

var matchLess = [new RegExp(/.*\.(less|css)/)];
var moreStyles = mergeTrees([
	new Funnel(unwatchedTree('app'), {
		srcDir: '/',
		destDir: '.',
		include: matchLess
	})
]);

// Begin "normal" ember-cli template

module.exports = function(defaults) {
	var app = new EmberApp(defaults, {
		lessOptions: {
			paths: [
				'app'
			]
		},
		fingerprint: {
			exclude: ['iframeResizer.min.js']
		},
		autoprefixer: {
			browsers: ['last 2 ios version'],
			cascade: false
		},
		trees: {
			styles: moreStyles
		}
	});


	// Use `app.import` to add additional libraries to the generated
	// output files.
	//
	// If you need to use different assets in different
	// environments, specify an object as the first parameter. That
	// object's keys should be the environment name and the values
	// should be the asset to use in that environment.
	//
	// If the library that you are including contains AMD or ES6
	// modules that you would like to import into your application
	// please specify an object with the list of modules as keys
	// along with the exports of each module as its value.
	app.import('vendor/jquery.min.js');
	app.import('vendor/validatr.min.js');
	app.import('vendor/iframeResizer.min.js');
	app.import('bower_components/he/he.js');

	return app.toTree();
};
