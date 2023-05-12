import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';

class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Nhật Vy',
              style: AppTextStyles.appBarText,
            ),
          ],
        ),
        handler: () => Navigator.of(context).pop(),
      ),
      body: ListView(),
    );
  }
}
