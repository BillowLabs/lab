global class FutureRequest {
	public String endpoint;
	public String method;
	public String handler;

	global void SetHandler(Type type) {
		Object obj = type.NewInstance();
		if ((obj instanceof IHttpResponseHandler) == false){
			throw new ApplicationException(type.getName() + ' must implement ' + IHttpResponseHandler.class.getName());
		}

		handler = type.getName();
	}

	global void SetEndpoint(String url) {
		endpoint = url;
		method = 'GET';
	}

	global void SetEndpoint(String url, String m) {
		endpoint = url;
		method = m;
	}
}