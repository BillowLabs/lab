public interface IHttpClient {
	HttpResponse Send(HttpRequest request);
	void Future(FutureRequest request);
}