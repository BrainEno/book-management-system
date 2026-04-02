import 'package:http/http.dart' as http;

class IsbnSender {
  Future<bool> sendIsbn(String isbn, String desktopUrl, {http.Client? client}) async {
    final httpClient = client ?? http.Client();
    try {
      final uri = Uri.parse('$desktopUrl/isbn');
      final response = await httpClient.post(
        uri,
        body: isbn,
        headers: {'Content-Type': 'text/plain'},
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }
}
