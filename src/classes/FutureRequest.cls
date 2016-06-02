global class FutureRequest {
	public String endpoint;
	public String method;
	public String handler;

	public void SetHandler(Type type) {
		Object obj = type.NewInstance();
		if ((obj instanceof IHttpResponseHandler) == false){
			throw new ApplicationException(type.getName() + ' must implement ' + IHttpResponseHandler.class.getName());
		}

		handler = type.getName();
	}

	public void Get(String url) {
		endpoint = url;
		method = 'GET';
	}
}