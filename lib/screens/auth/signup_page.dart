import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateless/signButton.dart';

import '../../widgets/stateless/input.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final input = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                margin:
                    EdgeInsets.only(top: 80, bottom: 20), //top: 100, left 50
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
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  children: <Widget>[
                    Input(
                      label: 'Mail đăng nhập',
                      hintText: 'xxxxxxxx@gm.uit.edu.vn',
                      textColor: AppColors.fade,
                      textfieldColor: AppColors.white,
                      handleChange: () => {},
                      inputKey: input,
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
                      inputKey: input,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Input(
                      label: 'Nhập lại mật khẩu',
                      hintText: 'Nhập mật khẩu',
                      textColor: AppColors.fade,
                      textfieldColor: AppColors.white,
                      handleChange: () => {},
                      inputKey: input,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: SignButton(
                  buttonText: 'Tiếp theo',
                  textColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
