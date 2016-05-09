public with sharing class Repository implements IRepository {
	public List<SObject> Read(String query){
		return Database.query(query);
	}
	public List<SObject> Read(SObject[] query) {
		return query;
	}
	public void Create(SObject value){
		insert value;
	}
	public void Create(List<SObject> values){
		insert values;
	}
	public void Modify(SObject value){
		update value;
	}
	public void Modify(List<SObject> values){
		update values;
	}
	public void Save(SObject value){
		upsert value;
	}
	public void Save(List<SObject> values){
		upsert values;
	}
	public void Remove(SObject value){
		delete value;
	}
	public void Remove(List<SObject> values){
		delete values;
	}
}
