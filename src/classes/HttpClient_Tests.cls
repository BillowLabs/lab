@isTest
private class HttpClient_Tests
{

	@isTest
	static void WhenMakingRequest_ShouldReturnResponse()
	{
		HttpClient client = new HttpClient();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('http://www.google.com');
		request.setMethod('GET');

		Test.setMock(HttpCalloutMock.class, new GoogleHttpCalloutMock());

		Test.startTest();
		HttpResponse response = client.Send(request);
		Test.stopTest();

		System.assert(response != null);
		System.assertEquals('Working', response.getBody());
		System.assertEquals(200, response.getStatusCode());
	}


	@isTest
	static void WhenMakingFutureRequest_ShouldHandleResponse()
	{
		HttpClient client = new HttpClient();
		FutureRequest request = new FutureRequest();
		request.Get('http://www.google.com');
		request.SetHandler(TestResponseHandler.class);

		Test.setMock(HttpCalloutMock.class, new GoogleHttpCalloutMock());

		Test.startTest();
		client.Future(request);
		Test.stopTest();

		System.assertEquals(1, TestResponseHandlerCalled);
	}


	private static Integer TestResponseHandlerCalled = 0;
	public class TestResponseHandler implements IHttpResponseHandler {
		// NOTE: this class must remain public in order to be instantiated as a handler.
		public void Handle(HttpResponse response) {
			HttpClient_Tests.TestResponseHandlerCalled++;
			System.assertEquals('Working', response.getBody());
			System.assertEquals(200, response.getStatusCode());
		}
	}


	private class GoogleHttpCalloutMock implements HttpCalloutMock {
		public HTTPResponse respond(HTTPRequest req) {

			System.assertEquals('http://www.google.com', req.getEndpoint());
			System.assertEquals('GET', req.getMethod());

			// Create a fake response
			HttpResponse res = new HttpResponse();
			res.setBody('Working');
			res.setStatusCode(200);
			return res;

		}
	}




}