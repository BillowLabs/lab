global interface ISettings {
	String Read(String key);
	Map<String, String> ReadAll(List<String> keys);
}
