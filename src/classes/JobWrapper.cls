global class JobWrapper implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return job.Query();
	}

	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		job.Process(scope);
	}

	global void finish(Database.BatchableContext BC) {
	}

	global JobWrapper(String n) {
		name = n;
		job = (IJob)Type.forName(name).NewInstance();
	}

	private String name;
	private IJob job;
}



// TODO: Record errors, record start time, record last error, etc.
// job.LabTools__LastRunOn__c = now;
// job.LabTools__LastError__c = '';
// job.LabTools__LastError__c = ex.getMessage();