import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

import 'package:you_it/widgets/stateless/signButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                ///  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 100), //top: 100, left 50
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
                  Form(
                    key: _formKey,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                              // label: 'Mail đăng nhập',
                              // hintText: 'xxxxxxxx@gm.uit.edu.vn',
                              // textColor: AppColors.fade,
                              // textfieldColor: AppColors.white,
                              // handleChange: () => {},
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Mail đăng nhập',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.white,
                                filled: true,
                              ),
                              onSaved: (value) {
                                _email = value!;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          // Input(
                          //   label: 'Mật khẩu',
                          //   hintText: 'Nhập mật khẩu',
                          //   textColor: AppColors.fade,
                          //   textfieldColor: AppColors.white,
                          //   handleChange: () => {},
                          // ),
                          TextFormField(
                            // label: 'Mail đăng nhập',
                            // hintText: 'xxxxxxxx@gm.uit.edu.vn',
                            // textColor: AppColors.fade,
                            // textfieldColor: AppColors.white,
                            // handleChange: () => {},
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            enableSuggestions: false,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              labelText: 'Mật khẩu',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.white,
                              filled: true,
                            ),
                            onSaved: (value) {
                              _password = value!;
                            },
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
                                  ..onTap = () {},
                              ),
                            ),
                          )
                        ],
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
                          buttonText: 'Đăng nhập',
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.white,
                          handler: () {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignButton(
                          buttonText: 'Đăng kí',
                          textColor: AppColors.white,
                          backgroundColor: AppColors.primaryColor,
                          handler: () {},
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
