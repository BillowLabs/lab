global class Faker {

	static Integer fakeIdCount = 1;
	public static String GetId(Schema.SObjectType sot)
	{
		 String count = String.valueOf(fakeIdCount++);
		 return sot.getDescribe().getKeyPrefix() + '0'.repeat(12-count.length()) + count;
	}
}
