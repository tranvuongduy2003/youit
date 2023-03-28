import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({Key? key}) : super(key: key);

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  String name = 'Nguyễn Hoàng Anh';
  String department = 'Công nghệ phần mềm';
  int seesion = 16;
  String address = 'Bình Dương';
  String birthDay = '18/08/2003';

  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final seesionController = TextEditingController();
  final addressController = TextEditingController();
  final birthDayController = TextEditingController();

  bool isEnable = false;

  @override
  void initState() {
    super.initState();
  }

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
              name = nameController.text;
              seesion = int.parse(seesionController.text);
              department = departmentController.text;
              address = addressController.text;
              birthDay = birthDayController.text;
              print(name);
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
                  labelText: 'Tên',
                  labelStyle: AppTextStyles.labelTextField,
                  errorText: '*Error lorem ipsum',
                  errorBorder: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                controller: nameController,
                onChanged: (value) {},
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Khoa',
                  labelStyle: AppTextStyles.labelTextField,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                controller: departmentController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Khoá',
                  labelStyle: AppTextStyles.labelTextField,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                controller: seesionController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nơi ở',
                  labelStyle: AppTextStyles.labelTextField,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                controller: addressController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Ngày sinh',
                  labelStyle: AppTextStyles.labelTextField,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                controller: birthDayController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
