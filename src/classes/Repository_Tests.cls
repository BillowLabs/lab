@isTest
private class Repository_Tests {

	@isTest static void WhenQuerying_ShouldReturnResults() {
		Account data = new Account(
			Name = 'Test Account'
		);
		insert data;


		Test.startTest();
		Repository repo = new Repository();
		List<Account> results = (List<Account>)repo.read('SELECT Id, Name FROM Account');
		Test.stopTest();


		System.assertEquals(1, results.size());
		System.assertEquals('Test Account', results[0].Name);
	}


	@isTest static void WhenEchoing_ShouldReturnGivenList() {
		List<Account> accounts = new List<Account> { new Account(
			Name = 'Test Account'
		)};


		List<Account> result;
		Test.startTest();
		Repository repo = new Repository();
		result = repo.echo(accounts);
		Test.stopTest();

		System.assertEquals(accounts, result);
	}


	@isTest static void WhenCreatingAccount_ShouldSaveAccount() {
		Account data = new Account(
			Name = 'Test Account'
		);


		Test.startTest();
		Repository repo = new Repository();
		repo.create(data);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(1, results.size());
		System.assertEquals('Test Account', results[0].Name);
	}


	@isTest static void WhenCreatingList_ShouldSaveResults() {
		Account data = new Account(
			Name = 'Test Account'
		);

		Account dataToo = new Account(
			Name = 'Test Account Too'
		);

		List<Account> dataList = new List<Account> {data, dataToo};


		Test.startTest();
		Repository repo = new Repository();
		repo.create(dataList);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(2, results.size());
		System.assertEquals('Test Account', results[0].Name);
		System.assertEquals('Test Account Too', results[1].Name);
	}


	@isTest static void WhenModifying_ShouldSaveResults() {
		Account data = new Account(
			Name = 'Test Account'
		);
		insert data;

		data.Name = 'Changed Test Account';

		Test.startTest();
		Repository repo = new Repository();
		repo.modify(data);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(1, results.size());
		System.assertEquals('Changed Test Account', results[0].Name);
	}


	@isTest static void WhenModifyingList_ShouldSaveResults() {
		Account data = new Account(
			Name = 'Test Account'
		);

		Account dataToo = new Account(
			Name = 'Test Account Too'
		);

		List<Account> dataList = new List<Account> {data, dataToo};
		insert dataList;


		for(Account a : dataList) { a.Name = 'Changed ' + a.Name; }

		Test.startTest();
		Repository repo = new Repository();
		repo.modify(dataList);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(2, results.size());
		System.assertEquals('Changed Test Account', results[0].Name);
		System.assertEquals('Changed Test Account Too', results[1].Name);
	}


	@isTest static void WhenSaving_ShouldCreateNewResults() {
		Account data = new Account(
			Name = 'Test Account'
		);

		Test.startTest();
		Repository repo = new Repository();
		repo.save(data);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(1, results.size());
		System.assertEquals('Test Account', results[0].Name);
	}


	@isTest static void WhenSaving_ShouldChangeResults() {
		Account data = new Account(
			Name = 'Test Account'
		);
		insert data;

		data.Name = 'Changed Test Account';

		Test.startTest();
		Repository repo = new Repository();
		repo.save(data);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(1, results.size());
		System.assertEquals('Changed Test Account', results[0].Name);
	}


	@isTest static void WhenSavingList_ShouldCreateAndChangeResults() {
		Account data = new Account(
			Name = 'Test Account'
		);
		insert data;

		data.Name = 'Changed Test Account';

		Account dataToo = new Account(
			Name = 'Test Account Too'
		);

		List<Account> dataList = new List<Account> {data, dataToo};

		Test.startTest();
		Repository repo = new Repository();
		repo.save(dataList);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(2, results.size());
		System.assertEquals('Changed Test Account', results[0].Name);
		System.assertEquals('Test Account Too', results[1].Name);
	}


	@isTest static void WhenRemoving_ShouldRemoveItems() {
		Account data = new Account(
			Name = 'Test Account'
		);
		insert data;


		Test.startTest();
		Repository repo = new Repository();
		repo.remove(data);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(0, results.size());
	}


	@isTest static void WhenRemovingList_ShouldRemoveItems() {
		Account data = new Account(
			Name = 'Test Account'
		);

		Account dataToo = new Account(
			Name = 'Test Account Too'
		);

		List<Account> dataList = new List<Account> {data, dataToo};
		insert dataList;

		Test.startTest();
		Repository repo = new Repository();
		repo.remove(dataList);
		Test.stopTest();

		List<Account> results = [SELECT Id, Name FROM Account];

		System.assertEquals(0, results.size());
	}
}
