import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/route/routes.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/sign_button.dart';

import '../../widgets/stateful/input_password.dart';
import '../../widgets/stateless/input.dart';

final _firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formField = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _handleLogin(context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final credential = await _firebase.signInWithEmailAndPassword(
          email: _email, password: _password);

      DatabaseService(uid: credential.user!.uid).setUserOnlineStatus(true);

      Navigator.of(context)
          .pushReplacementNamed(Routes.bottomNavBarWithGroupListPage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final input = GlobalKey<FormState>();
    return _isLoading
        ? Stack(
            children: [
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
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            ],
          )
        : Scaffold(
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
                      ///  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 80, bottom: 50),
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
                        Form(
                          key: _formField,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              children: <Widget>[
                                Input(
                                  exception: r'\S+@\S+\.\S+',
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
                                InputPassword(
                                  exception:
                                      r'^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#%&@"]).*$',
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
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.of(context)
                                            .pushNamed(
                                                Routes.forgotPasswordPage),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SignButton(
                                loading: _isLoading,
                                buttonText: 'Đăng nhập',
                                textColor: AppColors.white,
                                backgroundColor: AppColors.primaryColor,
                                handleOnPress: () {
                                  if (_formField.currentState!.validate()) {
                                    return _handleLogin(context);
                                  } else {
                                    print('error');
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SignButton(
                                buttonText: 'Đăng kí',
                                textColor: AppColors.primaryColor,
                                backgroundColor: AppColors.white,
                                handleOnPress: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.signUpPage);
                                },
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
