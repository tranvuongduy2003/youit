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
        alignment: Alignment.topCenter,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Input>[
                  Input(
                    'Mail đăng nhập',
                    'xxxxxxxx@gm.uit.edu.vn',
                    AppColors.fontColor,
                    AppColors.white,
                  ),
                  Input(
                    'Mật khẩu',
                    'Nhập mật khẩu',
                    AppColors.fontColor,
                    AppColors.white,
                  ),
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
