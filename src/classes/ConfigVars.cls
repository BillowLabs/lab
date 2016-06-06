global class ConfigVars implements IConfigVars {

	global String Read(String key) {
		List<LabTools__ConfigVar__c> results = [
			SELECT LabTools__Value__c
			FROM LabTools__ConfigVar__c
			WHERE Name = :key
		];

		if (results.size() == 0) return null;

		return results[0].LabTools__Value__c;
	}

	global Map<String, String> ReadAll(List<String> keys) {
		List<LabTools__ConfigVar__c> values = [
			SELECT Name, LabTools__Value__c
			FROM LabTools__ConfigVar__c
			WHERE Name = :keys
		];

		Map<String, String> result = new Map<String, String>();
		for(LabTools__ConfigVar__c var : values) {
			result.put(var.Name, var.LabTools__Value__c);
		}

		return result;
	}

}