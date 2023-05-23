import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateless/signButton.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80, bottom: 150), //top: 100, left 50
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SignButton(
                  buttonText: 'Đăng kí',
                  textColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  handler: () {},
                ),
                SignButton(
                  buttonText: 'Đăng nhập',
                  textColor: AppColors.primaryColor,
                  backgroundColor: AppColors.white,
                  handler: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
