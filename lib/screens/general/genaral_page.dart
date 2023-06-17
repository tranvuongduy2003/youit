import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../service/database_service.dart';
import '../../widgets/stateless/header_bar.dart';
import '../../widgets/stateless/text_circle_button.dart';

import '../../widgets/stateless/circle_button.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  bool _isLoading = false;
  signOut(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .setUserOnlineStatus(false);
      FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.logInPage, (route) => false);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: HeaderBar(
                isShowIconButton: false,
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
                          Navigator.of(context)
                              .pushNamed(Routes.changePasswordPage);
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
                        onPressed: () {
                          signOut(context);
                        },
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
