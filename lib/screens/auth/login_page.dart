import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateless/input.dart';
import 'package:you_it/widgets/stateless/signButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:you_it/config/route/routes.dart';

final _firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  void _handleLogin(context) async {
    try {
      final credential = await _firebase.signInWithEmailAndPassword(
          email: _email, password: _password);
      Navigator.of(context).pushNamed(Routes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
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
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80, bottom: 50),
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
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        Input(
                          label: 'Mail đăng nhập',
                          hintText: 'Nhập email đăng nhập',
                          textColor: AppColors.fade,
                          textfieldColor: AppColors.white,
                          handleChange: (value) => setState(() {
                            _email = value;
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Input(
                          label: 'Mật khẩu',
                          hintText: 'Nhập mật khẩu',
                          textColor: AppColors.fade,
                          textfieldColor: AppColors.white,
                          handleChange: (value) => setState(() {
                            _password = value;
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(right: 15),
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              text: 'Quên mật khẩu',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ),
                        )
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
                          handleOnPress: () {
                            Navigator.of(context).pushNamed(Routes.signUpPage);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignButton(
                          buttonText: 'Đăng nhập',
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.white,
                          handleOnPress: () => _handleLogin(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
