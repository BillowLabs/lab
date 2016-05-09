public virtual class RepositoryTestStub implements IRepository
{
	public class TestException extends Exception {}

	public virtual List<SObject> Read(String query){
		throw new TestException('You must override the Read(SObject values) method when using the RepositoryTestStub');
	}
	public virtual List<SObject> Read(List<SObject> query){
		throw new TestException('You must override the Read(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Create(SObject value){
		throw new TestException('You must override the Create(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Create(List<SObject> values){
		throw new TestException('You must override the Create(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Modify(SObject value){
		throw new TestException('You must override the Modify(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Modify(List<SObject> values){
		throw new TestException('You must override the Modify(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Save(SObject value){
		throw new TestException('You must override the Save(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Save(List<SObject> values){
		throw new TestException('You must override the Save(List<SObject> values) method when using the RepositoryTestStub');
	}
	public virtual void Remove(SObject value){
		throw new TestException('You must override the Remove(SObject value) method when using the RepositoryTestStub');
	}
	public virtual void Remove(List<SObject> values){
		throw new TestException('You must override the Remove(List<SObject> values) method when using the RepositoryTestStub');
	}
}
