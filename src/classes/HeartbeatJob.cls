public with sharing class HeartbeatJob implements IJob {

	public Database.QueryLocator Query() {
		System.debug('Heartbeat Job Started');
		return Database.getQueryLocator([SELECT Id FROM LabTools__Job__c]);
	}

	public void Process(List<sObject> scope) {
		System.debug('Heartbeat Job Executing');
		System.debug('Heartbeat Job - Number of Jobs: ' + scope.size());
	}

}
