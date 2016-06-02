@isTest
private class JobRunner_Tests {

	@isTest static void WhenHours_ShouldSetNextRunInHours() {
		TestRepo repo = new TestRepo('Hours', 2);
		Datetime now = Datetime.now();
		JobRunner jRunner = new JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addHours(2), ((LabTools__Runner__c)repo.Modified[0]).LabTools__NextRunOn__c);
	}


	@isTest static void WhenDays_ShouldSetNextRunInDays() {
		TestRepo repo = new TestRepo('Days', 3);
		Datetime now = Datetime.now();
		JobRunner jRunner = new JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addDays(3), ((LabTools__Runner__c)repo.Modified[0]).LabTools__NextRunOn__c);
	}


	@isTest static void WhenMonths_ShouldSetNextRunInMonths() {
		TestRepo repo = new TestRepo('Months', 4);
		Datetime now = Datetime.now();
		JobRunner jRunner = new JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addMonths(4), ((LabTools__Runner__c)repo.Modified[0]).LabTools__NextRunOn__c);
	}


	@isTest static void WhenYears_ShouldSetNextRunInYears() {
		TestRepo repo = new TestRepo('Years', 5);
		Datetime now = Datetime.now();
		JobRunner jRunner = new JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addYears(5), ((LabTools__Runner__c)repo.Modified[0]).LabTools__NextRunOn__c);
	}


	@isTest static void WhenIntegrating_ShouldNotFailRun() {
		LabTools__Runner__c runner = new LabTools__Runner__c(
			Name = 'Test',
			LabTools__RecurrenceRate__c = 1,
			LabTools__RecurrenceType__c = 'Hours',
			LabTools__StartOn__c = Datetime.now()
		);
		insert runner;

		List<LabTools__Job__c> testJobs = new List<LabTools__Job__c>();
		testJobs.add(new LabTools__Job__c(
			Name = HeartbeatJob.class.getName(),
			LabTools__Runner__c = runner.Id
		));
		insert testJobs;

		JobRunner jRunner = new JobRunner();

		Test.startTest();
		jRunner.execute();
		Test.stopTest();
	}




	private class TestRepo extends RepositoryTestStub {

		public Integer EchoCalled = 0;
		public override List<SObject> Echo(List<SObject> values) {
			EchoCalled++;
			return new List<LabTools__Runner__c> {
				new LabTools__Runner__c(
					LabTools__RecurrenceType__c = recurrenceType,
					LabTools__RecurrenceRate__c = recurrenceRate
				)
			};
		}

		public Integer ModifyCalled = 0;
		public List<SObject> Modified;
		public override void Modify(List<SObject> values) {
			ModifyCalled++;
			Modified = values;
		}


		public TestRepo(String t, Decimal r) {
			recurrenceType = t;
			recurrenceRate = r;
		}

		private String recurrenceType;
		private Decimal recurrenceRate;
	}

}
