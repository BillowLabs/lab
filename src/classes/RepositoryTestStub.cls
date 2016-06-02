// Marking test stubs as @isTest excludes them from code coverage
// However, in order to do so, the class can not be virtual as we want: #ThankYouSalesforce
public abstract class RepositoryTestStub implements IRepository
{
	public virtual List<SObject> Read(String query){
		throw new NotImplementedException('You must override the Read(SObject values) method when using the RepositoryTestStub');
	}
	public virtual List<SObject> Echo(List<SObject> query){
		throw new NotImplementedException('You must override the Echo(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Create(SObject value){
		throw new NotImplementedException('You must override the Create(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Create(List<SObject> values){
		throw new NotImplementedException('You must override the Create(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Modify(SObject value){
		throw new NotImplementedException('You must override the Modify(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Modify(List<SObject> values){
		throw new NotImplementedException('You must override the Modify(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Save(SObject value){
		throw new NotImplementedException('You must override the Save(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Save(List<SObject> values){
		throw new NotImplementedException('You must override the Save(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Remove(SObject value){
		throw new NotImplementedException('You must override the Remove(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Remove(List<SObject> values){
		throw new NotImplementedException('You must override the Remove(List<SObject> values) method when using the RepositoryTestStub');
	}
}