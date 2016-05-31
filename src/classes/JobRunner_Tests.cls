@isTest
private class JobRunner_Tests {

	// Because Jobs_Daily loads the jobs it runs dynamically,
	// the purpose of this class is to test that all those jobs exist.
	// Each job needs to be tested independantly so look for the individual
	// job tests to confirm they are tested correctly.
	// i.e. BrightLocal_DownloadSeoReports -> tested by: -> TEST_BrightLocal_DownloadSeoReports

	@isTest static void WhenRunning_ShouldNotFailOnLoadingJobs() {

		Test.startTest();
		// CRON expression: midnight on March 15.
		// Because this is a test, job executes immediately after Test.stopTest().
		System.schedule('JobRunner', '0 0 0 15 3 ? 2022', new JobRunner());
		Test.stopTest();

		// Pointless assert just to assert something.
		// As this test will fail based on the dynamic loading of classes,
		// there is nothing else we can assert.
		System.assert(true);
	}

}
