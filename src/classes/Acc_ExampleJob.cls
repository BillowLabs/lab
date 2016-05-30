global class Acc_ExampleJob implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([
			SELECT Id
			FROM Account
			LIMIT 10
		]);
	}

	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		List<Account> accounts = (List<Account>)scope;
		for (Account account : accounts) {
			account.Name = account.Name;
		}
		repository.Modify(accounts);
		repository.Modify(accounts[0]);
	}

	global void finish(Database.BatchableContext BC) {
		System.debug('Acc_ExampleJob finished');
	}

	public Acc_ExampleJob()
	{
		repository = new Repository();
	}

	@TestVisible private Acc_ExampleJob(IRepository r)
	{
		repository = r;
	}

	IRepository repository;

}