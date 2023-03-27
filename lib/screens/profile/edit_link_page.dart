import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditLinkPage extends StatelessWidget {
  const EditLinkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linkGhController = TextEditingController();
    final linkGlController = TextEditingController();
    final linkedinController = TextEditingController();

    final appBarTheme = AppBarTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: appBarTheme.centerTitle,
        elevation: appBarTheme.elevation,
        leading: TextButton(
          child: Text(
            'Huỷ',
            style: appBarTheme.toolbarTextStyle,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Thông tin cá nhân',
          style: appBarTheme.titleTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Lưu',
              style: appBarTheme.toolbarTextStyle,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.lineColor,
            height: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Github',
                labelStyle: AppTextStyles.labelTextField,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
              ),
              controller: linkGhController,
              onChanged: (value) {},
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Gitlab',
                labelStyle: AppTextStyles.labelTextField,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
              ),
              controller: linkGlController,
              onChanged: (value) {},
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Linkedin',
                labelStyle: AppTextStyles.labelTextField,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
              ),
              controller: linkedinController,
              onChanged: (value) {},
            ),
          ])),
    );
  }
}
