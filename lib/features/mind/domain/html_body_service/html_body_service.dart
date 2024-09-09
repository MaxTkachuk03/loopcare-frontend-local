import 'package:dio/dio.dart';

class HtmlBodyService {
  /// Executes an HTTP or HTTPS request and returns the body as HTML code
  static Future<String> getBodyFromHtml(String url) async {
    String body = '';

    try {
      final response = await Dio().get(url);
      if (response.data is String) {
        body = response.data;
      }
    } catch (e) {
      // ignore
    }

    return body;
  }
}
