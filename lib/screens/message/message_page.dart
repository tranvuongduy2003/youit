import 'package:flutter/material.dart';

import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/input.dart';
import 'package:you_it/widgets/stateless/message_user.dart';
import '../../widgets/stateless/header_bar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    final headerBar = HeaderBar(
      title: Text(
        'Trò chuyện',
        style: AppTextStyles.appBarText,
      ),
      handler: () => Navigator.of(context).pop(),
    );

    final listViewHeight =
        MediaQuery.of(context).size.height - HeaderBar.headerHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: Text(
          'Trò chuyện',
          style: AppTextStyles.appBarText,
        ),
        handler: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: listViewHeight * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Input(
                    exception: "",
                    label: null,
                    hintText: 'Tìm kiếm',
                    textColor: AppColors.fontColor,
                    textfieldColor: Color(0xFFE6E6E6),
                    handleChange: () => {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  color: AppColors.lineColor,
                  height: 1.0,
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 90.0,
              maxHeight: listViewHeight * 0.8,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (ctx, i) => MessageUser(),
            ),
          )
        ],
      ),
    );
  }
}
