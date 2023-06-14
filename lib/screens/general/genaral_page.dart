import 'package:flutter/material.dart';
import 'package:you_it/config/route/routes.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../widgets/stateless/header_bar.dart';
import '../../widgets/stateless/text_circle_button.dart';

import '../../widgets/stateless/circle_button.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
          isIconButton: false,
          title: Text(
            'Cài đặt',
            style: AppTextStyles.appBarText,
          ),
          handler: () {}),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            TextCircleButton(
              btn: CircleButton(
                  isImageButton: false,
                  icon: Icon(
                    Icons.sunny,
                    color: Colors.white,
                    size: 33,
                  ),
                  buttonColor: Colors.white,
                  onPressed: () {},
                  size: 60),
              txt: 'Chế độ',
            ),
            TextCircleButton(
              btn: CircleButton(
                  isImageButton: false,
                  icon: Icon(
                    Icons.key_sharp,
                    size: 33,
                  ),
                  buttonColor: AppColors.yellow,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.changePasswordPage);
                  },
                  size: 60),
              txt: 'Đổi mật khẩu',
            ),
            TextCircleButton(
              btn: CircleButton(
                  isImageButton: false,
                  icon: Icon(
                    Icons.logout,
                    size: 33,
                  ),
                  buttonColor: AppColors.pinkRed,
                  onPressed: () {},
                  size: 60),
              txt: 'Đăng xuất',
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomTabBar(),
    );
  }
}
