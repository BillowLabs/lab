// Marking test stubs as @isTest excludes them from code coverage
// However, in order to do so, the class can not be virtual as we want: #ThankYouSalesforce
public abstract class HttpClientTestStub implements IHttpClient {
	public virtual HttpResponse Send(HttpRequest request) {
		throw new NotImplementedException('You must override the Send(HttpRequest request) method when using the HttpClientTestStub');
	}
	public virtual void Future(FutureRequest request) {
		throw new NotImplementedException('You must override the Future(FutureRequest request) method when using the HttpClientTestStub');
	}
}
