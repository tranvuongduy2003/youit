import 'package:flutter/material.dart';
import '../../widgets/stateless/header_bar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        appBar: AppBar(),
        title: 'Trò chuyện',
        handler: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
