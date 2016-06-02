global class Settings implements ISettings {

	global String Read(String key) {
		List<LabTools__Setting__c> results = [
			SELECT LabTools__Value__c
			FROM LabTools__Setting__c
			WHERE Name = :key
		];

		if (results.size() == 0) return null;

		return results[0].LabTools__Value__c;
	}

	global Map<String, String> ReadAll(List<String> keys) {
		List<LabTools__Setting__c> values = [
			SELECT Name, LabTools__Value__c
			FROM LabTools__Setting__c
			WHERE Name = :keys
		];

		Map<String, String> result = new Map<String, String>();
		for(LabTools__Setting__c setting : values) {
			result.put(setting.Name, setting.LabTools__Value__c);
		}

		return result;
	}

}