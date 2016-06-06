@isTest
private class ConfigVars_Tests
{
	@isTest
	static void WhenIntegrating_ShouldReturnValue()
	{
		LabTools__ConfigVar__c var = new LabTools__ConfigVar__c(
			Name = 'Test Setting',
			LabTools__Value__c = 'Test!'
		);
		insert var;

		ConfigVars vars = new ConfigVars();


		Test.startTest();
		String value = vars.Read('Test Setting');
		Test.stopTest();

		System.assertEquals('Test!', value);
	}


	@isTest
	static void WhenIntegrating_ShouldReturnValues()
	{
		LabTools__ConfigVar__c varOne = new LabTools__ConfigVar__c(
			Name = 'Test One',
			LabTools__Value__c = 'Test 1'
		);

		LabTools__ConfigVar__c varTwo = new LabTools__ConfigVar__c(
			Name = 'Test Two',
			LabTools__Value__c = 'Test 2'
		);

		insert new List<LabTools__ConfigVar__c> {varOne, varTwo};


		List<String> keys = new List<String> {varOne.Name, varTwo.Name};

		ConfigVars vars = new ConfigVars();

		Test.startTest();
		Map<String, String> values = vars.ReadAll(keys);
		Test.stopTest();

		System.assertEquals(2, values.size());
		System.assertEquals('Test 1', values.get('Test One'));
		System.assertEquals('Test 2', values.get('Test Two'));
	}

}