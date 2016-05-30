@isTest
private class Acc_ExampleJob_Tests {

	@isTest static void WhenRunning_ShouldNotFailOnLoadingJobs() {

		WhenRunning_ShouldNotFailOnLoadingJobsRepo repo = new WhenRunning_ShouldNotFailOnLoadingJobsRepo();

		Acc_ExampleJob job = new Acc_ExampleJob(repo);

		List<Account> testData = new List<Account>{
			new Account(Id=Faker.GetId(Account.SObjectType))
		};

		Test.startTest();
		job.execute(null, testData);
		Test.stopTest();

	}

	private class WhenRunning_ShouldNotFailOnLoadingJobsRepo extends RepositoryTestStub {
		public override void Modify(List<SObject> values) {
			System.assertEquals(1, values.size());
		}
		public override void Modify(SObject value) {
			System.assert(value.Id != null);
		}
	}

}
