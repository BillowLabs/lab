@isTest
private class HeartbeatJob_Tests
{
	@isTest static void WhenStarts_ShouldReturnAccountsList()
	{
		HeartbeatJob job = new HeartbeatJob();

		Test.startTest();
		Database.QueryLocator locator = job.start(null);
		Test.stopTest();

		System.assert(locator != null);
	}


	@isTest static void WhenExecutes_ShouldNotFail()
	{
		HeartbeatJob job = new HeartbeatJob();

		Test.startTest();
		job.execute(null, null);
		Test.stopTest();

		System.assert(true);
	}


	@isTest static void WhenFinishes_ShouldNotFail()
	{
		HeartbeatJob job = new HeartbeatJob();

		Test.startTest();
		job.finish(null);
		Test.stopTest();

		System.assert(true);
	}
}
