import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';

class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: Text(
          'Nhật Vy',
          style: AppTextStyles.appBarText,
        ),
        appBar: AppBar(),
        handler: () => Navigator.of(context).pop(),
      ),
      body: Container(),
    );
  }
}
