global class HeartbeatJob implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {
		System.debug('Heartbeat Job Started');
		return Database.getQueryLocator([SELECT Id FROM Account WHERE Id = NULL]);
	}

	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		System.debug('Heartbeat Job Executing');
	}

	global void finish(Database.BatchableContext BC) {
		System.debug('Heartbeat Job Finished');
	}

}
