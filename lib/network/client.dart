import 'package:http/http.dart' as http;

class Client {
  String baseUrl = 'youit-server-production-2517.up.railway.app';

  Future<void> sendMessageToGroup({
    required String groupId,
    required String title,
    required String body,
  }) async {
    final url = Uri.https(baseUrl, 'send-group-message');
    try {
      await http
          .post(url, body: {'title': title, 'body': body, 'topic': groupId});
    } catch (e) {
      print(e);
    }
  }
}
