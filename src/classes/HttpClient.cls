public with sharing class HttpClient implements IHttpClient {

	public HttpResponse Send(HttpRequest request) {
		return (new Http()).send(request);
	}

	public void Future(FutureRequest request) {
		AsyncCall(JSON.serialize(request));
	}

	@future (callout=true)
	private static void AsyncCall(String jRequest) {
		FutureRequest fRequest = (FutureRequest)JSON.deserialize(jRequest, FutureRequest.class);

		HttpRequest request = new HttpRequest();
		request.setEndpoint(fRequest.endpoint);
		request.setMethod(fRequest.method);

		HttpResponse result = (new Http()).send(request);

		if (fRequest.handler == null) return;
		System.debug('Handling with: ' + fRequest.handler);

		Type targettype = Type.forName(fRequest.handler);
		IHttpResponseHandler handler = (IHttpResponseHandler)targettype.NewInstance();
		handler.handle(result);
	}
}