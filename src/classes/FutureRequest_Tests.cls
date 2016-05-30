@isTest
private class FutureRequest_Tests
{
	@isTest
	static void WhenUsingGet_ShouldSetMethodAndEndpoint()
	{
		FutureRequest request = new FutureRequest();

		Test.startTest();
		request.Get('http://www.google.com');
		Test.stopTest();

		System.assertEquals('http://www.google.com', request.endpoint);
		System.assertEquals('GET', request.method);
	}


	@isTest
	static void WhenSettingHandler_ShouldUseTypeName()
	{
		FutureRequest request = new FutureRequest();

		Test.startTest();
		request.SetHandler(TestResponseHandler.class);
		Test.stopTest();

		System.assertEquals(TestResponseHandler.class.getName(), request.handler);
	}


	@isTest
	static void WhenHandlerDoesntImplementInterface_ShouldThrowException()
	{
		FutureRequest request = new FutureRequest();
		Boolean exceptionThrown = false;

		Test.startTest();
		try {
			request.SetHandler(FutureRequest_Tests.class);
		} catch(ApplicationException ex) {
			exceptionThrown = true;
		}
		Test.stopTest();

		System.assert(exceptionThrown);
	}


	public class TestResponseHandler implements IHttpResponseHandler {
		// NOTE: this class must remain public in order to be instantiated as a handler.
		public void Handle(HttpResponse response) {}
	}
}