@isTest
private class JobRunnerSchedule_Tests
{
	@isTest static void WhenConstructing_ShouldNotFail()
	{
		// Because JobRunnerSchedule loads the job it runs dynamically,
		// the purpose of this class is to test that the job exists.
		// JobRunner needs to be tested independantly so look to JobRunner_Tests
		// to confirm it is tested correctly.

		Test.startTest();
		JobRunnerSchedule schedule = new JobRunnerSchedule();
		Test.stopTest();

		System.assert(schedule.schedulable != null);
	}


	@isTest static void WhenExecuting_ShouldExecuteSchedulableOnce()
	{
		TestSchedulable schedulable = new TestSchedulable();
		JobRunnerSchedule schedule = new JobRunnerSchedule(schedulable);

		Test.startTest();
		schedule.execute(null);
		Test.stopTest();

		System.assertEquals(1, schedulable.ExecuteCount);
	}


	private class TestSchedulable implements ISchedulable {
		Integer ExecuteCount = 0;

		public void execute() {
			ExecuteCount++;
		}
	}
}
