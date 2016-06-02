global class HeartbeatJob implements IJob {

	global Database.QueryLocator Query() {
		System.debug('Heartbeat Job Started');
		return Database.getQueryLocator([SELECT Id FROM LabTools__Job__c]);
	}

	global void Process(List<sObject> scope) {
		System.debug('Heartbeat Job Executing');
		System.debug('Heartbeat Job - Number of Jobs: ' + scope.size());
	}

}