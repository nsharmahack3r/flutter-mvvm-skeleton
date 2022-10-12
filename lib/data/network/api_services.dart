abstract class ApiService{
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPatchApiResponse(String url, dynamic data);
}