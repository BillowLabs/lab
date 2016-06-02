// To Run Every Hour: System.schedule('JobRunnerSchedule', '0 0 * * * ?', new JobRunnerSchedule());
// SEE: http://salesforce.stackexchange.com/questions/16337/schedule-hourly-batch-using-cron-expression-start-on-abritrary-day-of-month

global class JobRunnerSchedule implements Schedulable {

	global void execute(SchedulableContext sc) {
		schedulable.execute();
	}

	global JobRunnerSchedule() {
		schedulable = (ISchedulable)Type.forName('LabTools.JobRunner').NewInstance();
	}

	@TestVisible private JobRunnerSchedule(ISchedulable s)
	{
		schedulable = s;
	}

	private ISchedulable schedulable;
}