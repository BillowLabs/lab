@isTest
private class Settings_Tests
{
	@isTest
	static void WhenIntegrating_ShouldReturnValue()
	{
		LabTools__Setting__c setting = new LabTools__Setting__c(
			Name = 'Test Setting',
			LabTools__Value__c = 'Test!'
		);
		insert setting;

		Settings settings = new Settings();


		Test.startTest();
		String value = settings.Read('Test Setting');
		Test.stopTest();

		System.assertEquals('Test!', value);
	}


	@isTest
	static void WhenIntegrating_ShouldReturnValues()
	{
		LabTools__Setting__c settingOne = new LabTools__Setting__c(
			Name = 'Test One',
			LabTools__Value__c = 'Test 1'
		);

		LabTools__Setting__c settingTwo = new LabTools__Setting__c(
			Name = 'Test Two',
			LabTools__Value__c = 'Test 2'
		);

		insert new List<LabTools__Setting__c> {settingOne, settingTwo};


		List<String> keys = new List<String> {settingOne.Name, settingTwo.Name};

		Settings settings = new Settings();

		Test.startTest();
		Map<String, String> values = settings.ReadAll(keys);
		Test.stopTest();

		System.assertEquals(2, values.size());
		System.assertEquals('Test 1', values.get('Test One'));
		System.assertEquals('Test 2', values.get('Test Two'));
	}

}