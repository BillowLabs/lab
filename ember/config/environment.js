/* jshint node: true */

module.exports = function(environment) {
	var ENV = {
		modulePrefix: 'beacon',
		podModulePrefix: 'beacon/pods',
		environment: environment,
		baseURL: '/',
		locationType: 'hash',
		EmberENV: {
			FEATURES: {
				// Here you can enable experimental features on an ember canary build
				// e.g. 'with-controller': true
			}
		},

		APP: {
			// Here you can pass flags/options to your application instance
			// when it is created
		},

		contentSecurityPolicy: {
			'style-src': "'self' 'unsafe-inline' sheet https://fonts.googleapis.com",
			'script-src': "'self' 'unsafe-inline' 'unsafe-eval'",
			'connect-src': "'self'",
			'img-src': "'self'",
			'font-src' : "'self' https://fonts.gstatic.com"
		}
	};

	if (environment === 'development') {
		// ENV.APP.LOG_RESOLVER = true;
		// ENV.APP.LOG_ACTIVE_GENERATION = true;
		// ENV.APP.LOG_TRANSITIONS = true;
		// ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
		// ENV.APP.LOG_VIEW_LOOKUPS = true;
		ENV['ember-cli-mirage'] = {
			enabled: true
		}
	}

	if (environment === 'test') {
		// Testem prefers this...
		ENV.baseURL = '/';
		ENV.locationType = 'none';

		// keep test console output quieter
		ENV.APP.LOG_ACTIVE_GENERATION = false;
		ENV.APP.LOG_VIEW_LOOKUPS = false;
		ENV.APP.rootElement = '#ember-testing';
	}

	if (environment === 'production') {
		ENV.liveReload = false;
		// TODO: Disable by default when api is hooked up
		ENV['ember-cli-mirage'] = {
			enabled: false
		}
	}

	return ENV;
};
