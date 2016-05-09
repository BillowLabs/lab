global class Jobs_Daily implements Schedulable {
	global void execute(SchedulableContext sc) {

		// TODO: build a page that will allow you to run the job once
		// TODO: make this run dynamically based on string values in some table.

		List<string> batchJobs = new List<string> {
			'Acc_ExampleJob'
		};

		for(String job : batchJobs) {
			Type targettype = Type.forName(job);
			Database.Batchable<sObject> obj = (Database.Batchable<sObject>)targettype.NewInstance();
			Database.executebatch(obj);
		}

	}
}