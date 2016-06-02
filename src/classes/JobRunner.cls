public with sharing class JobRunner implements ISchedulable {

	public void execute() {

		if (now == null) now = DateTime.now();
		List<LabTools__Runner__c> runners = repository.Echo([
			SELECT Name, LabTools__RecurrenceType__c, LabTools__RecurrenceRate__c, (SELECT Name, LabTools__Enabled__c FROM LabTools__Jobs__r)
			FROM LabTools__Runner__c
			WHERE LabTools__StartOn__c <= :now
				AND (LabTools__NextRunOn__c = NULL OR LabTools__NextRunOn__c <= :now)
			ORDER BY LabTools__NextRunOn__c DESC
			LIMIT 5
		]);

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
				Database.executebatch(new JobWrapper(job.Name));
			}

		}

		repository.Modify(runners);
	}



	public JobRunner() {
		repository = new Repository();
	}

	@TestVisible private JobRunner(IRepository r, DateTime n)
	{
		repository = r;
		now = n;
	}



	private IRepository repository;
	private DateTime now;

}
