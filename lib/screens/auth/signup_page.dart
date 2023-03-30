import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateless/input.dart';
import 'package:you_it/widgets/stateless/signButton.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 100, bottom: 50), //top: 100, left 50
                child: Text(
                  'CHÀO MỪNG BẠN \nĐẾN VỚI YOUIT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  children: <Widget>[
                    Input(
                      label: 'Mail đăng nhập',
                      hintText: 'xxxxxxxx@gm.uit.edu.vn',
                      textColor: AppColors.fade,
                      textfieldColor: AppColors.white,
                      handleChange: () => {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Input(
                      label: 'Mật khẩu',
                      hintText: 'Nhập mật khẩu',
                      textColor: AppColors.fade,
                      textfieldColor: AppColors.white,
                      handleChange: () => {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Input(
                      label: 'Nhập lại mật khẩu',
                      hintText: 'Nhập lại mật khẩu',
                      textColor: AppColors.fade,
                      textfieldColor: AppColors.white,
                      handleChange: () => {},
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SignButton(
                      buttonText: 'Đăng kí',
                      textColor: AppColors.white,
                      backgroundColor: AppColors.primaryColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SignButton(
                      buttonText: 'Đăng nhập',
                      textColor: AppColors.primaryColor,
                      backgroundColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
