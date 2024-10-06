import "package:e_commerce/config/path_export.dart";


class BaseService {
  var https = RetryClient(Client());

  Future<Response> httpGet(String url) async {
    Logger.debug("GET Url", url);
    try {
      final response =
      await https.get(Uri.parse(url));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


}
