import 'package:http/http.dart' as http;

class Client {
  String baseUrl = '192.168.81.219:3000';

  Future<void> sendMessageToGroup({
    required String groupId,
    required String title,
    required String body,
  }) async {
    final url = Uri.http(baseUrl, 'send-group-message');
    try {
      await http
          .post(url, body: {'title': title, 'body': body, 'topic': groupId});
    } catch (e) {
      print(e);
    }
  }
}
