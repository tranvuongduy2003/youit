import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/input.dart';
import '../../widgets/stateless/sign_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formField = GlobalKey<FormState>();
  String _email = '';

  Future passwordReset(context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Link has been sent to your e-mail'),
        backgroundColor: Colors.green,
      ));
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
              actions: [
                TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
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
                ///  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80, bottom: 50),
                    child: Text(
                      'Chúng tôi sẽ gửi link đổi lại mật khẩu vào email của bạn',
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Input(
                        exception: r'\S+@\S+\.\S+',
                        label: 'Mail đăng nhập',
                        hintText: 'Nhập email đăng nhập',
                        textColor: AppColors.fade,
                        textfieldColor: AppColors.white,
                        handleChange: (value) => setState(() {
                          _email = value;
                        }),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SignButton(
                          buttonText: 'Gửi',
                          textColor: AppColors.white,
                          backgroundColor: AppColors.primaryColor,
                          handleOnPress: () {
                            if (_formField.currentState!.validate()) {
                              passwordReset(context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignButton(
                          buttonText: 'Quay lại',
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.white,
                          handleOnPress: () {
                            Navigator.of(context).pop();
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
