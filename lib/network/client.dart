import 'package:http/http.dart' as http;

class Client {
  String baseUrl = 'http://localhost:3000';

  Future<void> sendMessageToGroup(
      {required String groupId,
      required Map<String, dynamic> notification}) async {
    final url = Uri.http(baseUrl, 'send-group-message');
    try {
      await http.post(url, body: notification);
    } catch (e) {
      print(e);
    }
  }
}
