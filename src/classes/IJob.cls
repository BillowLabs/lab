global interface IJob {
	Database.QueryLocator Query();
	void Process(List<sObject> selected);
}