import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateless/input.dart';
import 'package:you_it/widgets/stateless/signButton.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 70), //top: 100, left 50
              child: Text(
                'CHÀO MỪNG BẠN \nĐẾN VỚI YOUIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-SemiBold',
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Input(
                    'Mail đăng nhập',
                    'xxxxxxxx@gm.uit.edu.vn',
                    AppColors.fade,
                    AppColors.white,
                  ),
                  Input(
                    'Mật khẩu',
                    'Nhập mật khẩu',
                    AppColors.fade,
                    AppColors.white,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 15),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Quên mật khẩu',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SignButton(
                    'Đăng kí',
                    AppColors.white,
                    AppColors.primaryColor,
                  ),
                  SignButton(
                    'Đăng nhập',
                    AppColors.primaryColor,
                    AppColors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
