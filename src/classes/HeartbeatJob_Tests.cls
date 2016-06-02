@isTest
private class HeartbeatJob_Tests
{


	@isTest static void WhenStarts_ShouldReturnLocator()
	{
		HeartbeatJob job = new HeartbeatJob();

		Test.startTest();
		Database.QueryLocator locator = job.Query();
		Test.stopTest();

		System.assert(locator != null);
	}


	@isTest static void WhenProcesses_ShouldNotFail()
	{
		HeartbeatJob job = new HeartbeatJob();

		Test.startTest();
		job.Process(new List<LabTools__Job__c>());
		Test.stopTest();

		System.assert(true);
	}

}