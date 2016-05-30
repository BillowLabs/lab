global class Jobs {
	global static void execute(String frequency) {

		// TODO: build a page that will allow you to run the job once
		List<LabTools__Job__c> batchJobs = [
			SELECT Name
			FROM LabTools__Job__c
			WHERE LabTools__Frequency__c = :frequency
		];


		for(LabTools__Job__c job : batchJobs) {
			try{

				Type targettype = Type.forName(job.Name);

				Database.Batchable<sObject> obj = (Database.Batchable<sObject>)targettype.NewInstance();
				Database.executebatch(obj);

				job.LabTools__LastRunOn__c = Date.today();
				job.LabTools__StartUpError__c = '';
				update job;

			} catch(Exception ex) {

				job.LabTools__StartUpError__c = ex.getMessage();
				update job;
				throw ex;

			}
		}

	}
}