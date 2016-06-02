@isTest
private class Faker_Tests
{
	@isTest
	static void WhenGettingFakeId_ShouldMatchSalesforcePattern()
	{
		Test.startTest();
		Id fakeAccountId = Faker.GetId(Account.SObjectType);
		Test.stopTest();

		System.assertEquals('001000000000001AAA', fakeAccountId);
	}
}