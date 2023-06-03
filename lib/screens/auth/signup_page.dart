import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateful/input_password.dart';
import 'package:you_it/widgets/stateless/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config/route/routes.dart';
import '../../widgets/stateless/input.dart';

final _firebase = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formField = GlobalKey<FormState>();
  bool checkRePassword = false;
  String _confirmPassword = '';
  String _email = '';
  String _password = '';

  void _handleSignUp() async {
    try {
      final credential = await _firebase.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
              Form(
                key: _formField,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Column(
                    children: <Widget>[
                      Input(
                        exception: r'\S+@\S+\.\S+',
                        label: 'Mail đăng nhập',
                        hintText: 'xxxxxxxx@gm.uit.edu.vn',
                        textColor: AppColors.fade,
                        textfieldColor: AppColors.white,
                        handleChange: (val) => setState(() {
                          _email = val;
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
                      InputPassword(
                        isNotConfirmed: checkRePassword,
                        exception:
                            r'^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#%&@"]).*$',
                        label: 'Nhập lại mật khẩu',
                        hintText: 'Nhập mật khẩu',
                        textColor: AppColors.fade,
                        textfieldColor: AppColors.white,
                        handleChange: (val) =>
                            setState(() => {_confirmPassword = val}),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: SignButton(
                  buttonText: 'Tiếp theo',
                  textColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  handleOnPress: () {
                    if (_formField.currentState!.validate() &&
                        _password == _confirmPassword) {
                      Navigator.of(context).pushNamed(Routes.fillInfoPage);
                    }
                    if (_password != _confirmPassword) {
                      checkRePassword = false;
                    }
                    if (_password == _confirmPassword) {
                      checkRePassword = true;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
