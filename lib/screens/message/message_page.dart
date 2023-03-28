import 'package:flutter/material.dart';
import '../../widgets/stateless/header_bar.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
          appBar: AppBar(),
          title: 'Trò chuyện',
          handler: () => Navigator.of(context).pop()),
    );
  }
}
