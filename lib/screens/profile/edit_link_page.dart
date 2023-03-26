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
            // onPressed: (nameController.text.isEmpty ||
            //         seesionController.text.isEmpty ||
            //         departmentController.text.isEmpty ||
            //         addressController.text.isEmpty ||
            //         birthDayController.text.isEmpty)
            //     ? null
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
              controller: linkGhController,
              onChanged: (value) {},
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Linkedin',
                labelStyle: AppTextStyles.labelTextField,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
              ),
              controller: linkGhController,
              onChanged: (value) {},
            ),
          ])),
    );
  }
}
