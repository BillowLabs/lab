global class JobRunner implements Schedulable {

	// To Run Every Hour: System.schedule('JobRunner', '0 0 * * * ?', new JobRunner());
	// SEE: http://salesforce.stackexchange.com/questions/16337/schedule-hourly-batch-using-cron-expression-start-on-abritrary-day-of-month
	global void execute(SchedulableContext sc) {

		DateTime now = DateTime.now();
		List<LabTools__Runner__c> runners = repository.Echo([
			SELECT Name, (SELECT Name FROM LabTools__Jobs__r)
			FROM LabTools__Runner__c
			WHERE LabTools__StartOn__c <= :now
				AND (LabTools__NextRunOn__c = NULL OR LabTools__NextRunOn__c <= :now)
			ORDER BY LabTools__NextRunOn__c DESC
			LIMIT 5
		]);

		// LabTools__LastEndedOn__c
		// LabTools__LastError__c
		// LabTools__Runner__c
		List<LabTools__Job__c> jobs = new List<LabTools__Job__c>();

		for(LabTools__Runner__c runner : runners) {

			DateTime next;
			if (runner.LabTools__RecurrenceType__c == 'Hours') {
				next = now.addHours((Integer)runner.LabTools__RecurrenceRate__c);
			} else if (runner.LabTools__RecurrenceType__c == 'Days') {
				next = now.addDays((Integer)runner.LabTools__RecurrenceRate__c);
			} else if (runner.LabTools__RecurrenceType__c == 'Months') {
				next = now.addMonths((Integer)runner.LabTools__RecurrenceRate__c);
			} else if (runner.LabTools__RecurrenceType__c == 'Years') {
				next = now.addYears((Integer)runner.LabTools__RecurrenceRate__c);
			}

			runner.LabTools__LastRunOn__c = now;
			runner.LabTools__NextRunOn__c = next;


			for(LabTools__Job__c job : runner.LabTools__Jobs__r) {
				if (job.LabTools__Enabled__c == false) continue;

				try {

					// TODO: Extend Database.Batchable<sObject> so we can
					// record errors, record start time, record last error, etc.
					job.LabTools__LastRunOn__c = now;
					job.LabTools__LastError__c = '';
					jobs.add(job);

					Type targettype = Type.forName(job.Name);
					Database.Batchable<sObject> obj = (Database.Batchable<sObject>)targettype.NewInstance();
					// TODO: Extend Database.Batchable<sObject> so we can record errors etc.
					Database.executebatch(obj);

				} catch(Exception ex) {

					job.LabTools__LastError__c = ex.getMessage();

				}
			}
		}

		repository.Modify(runners);
		repository.Modify(jobs);
	}



	public JobRunner() {
		repository = new Repository();
	}

	@TestVisible private JobRunner(IRepository r)
	{
		repository = r;
	}


	IRepository repository;

}
