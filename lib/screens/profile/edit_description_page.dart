import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditDescriptionPage extends StatelessWidget {
  const EditDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: TextButton(
          child: const Text(
            'Huỷ',
            style: AppTextStyles.appbarButtonTitle,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: AppTextStyles.sectionTitle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Lưu',
              style: AppTextStyles.appbarButtonTitle,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Mô tả',
                  labelStyle: AppTextStyles.labelTextField,
                  errorText: '*Error lorem ipsum',
                  errorBorder: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
