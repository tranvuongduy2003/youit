import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:you_it/config/route/routes.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateful/input_password.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';
import 'package:you_it/widgets/stateless/sign_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _newPassword = '';
  String _confirmNewPassword = '';
  final _formField = GlobalKey<FormState>();
  final _currentUser = FirebaseAuth.instance.currentUser;
  bool _checkPasswordMatched = false;

  Future changePassword(context) async {
    try {
      if (_formField.currentState!.validate() &&
          _newPassword == _confirmNewPassword) {
        await _currentUser!.updatePassword(_newPassword);
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushNamed(Routes.logInPage);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Mật khẩu đã thay đổi thành công.\n Vui lòng đăng nhập lại'),
          backgroundColor: Colors.green,
        ));
      }
    } on FirebaseAuthException catch (e) {
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
      appBar: HeaderBar(
          title: Text(
            'Đổi mật khẩu',
            style: AppTextStyles.appBarText,
          ),
          handler: () {
            Navigator.of(context).pop();
          }),
      body: Form(
        key: _formField,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputPassword(
                      label: 'Mật khẩu mới',
                      labelColor: Colors.black,
                      hintText: 'Nhập mật khẩu mới',
                      textColor: Colors.black,
                      textfieldColor: Colors.transparent.withOpacity(0.5),
                      handleChange: (value) {
                        setState(() {
                          _newPassword = value;
                        });
                        if (value != _confirmNewPassword) {
                          setState(() {
                            _checkPasswordMatched = false;
                          });
                        } else {
                          setState(() {
                            _checkPasswordMatched = true;
                          });
                        }
                      },
                      exception:
                          r'^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#%&@"]).*$'),
                  SizedBox(
                    height: 30,
                  ),
                  InputPassword(
                      isConfirmed: _checkPasswordMatched,
                      label: 'Nhập lại mật khẩu mới',
                      labelColor: Colors.black,
                      hintText: 'Nhập lại mật khẩu mới',
                      textColor: Colors.black,
                      textfieldColor: Colors.transparent.withOpacity(0.5),
                      handleChange: (value) {
                        setState(() {
                          _confirmNewPassword = value;
                        });
                        if (_newPassword != value) {
                          setState(() {
                            _checkPasswordMatched = false;
                          });
                        } else {
                          setState(() {
                            _checkPasswordMatched = true;
                          });
                        }
                      },
                      exception:
                          r'^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#%&@"]).*$'),
                  SizedBox(
                    height: 30,
                  ),
                  SignButton(
                      buttonText: 'Xác nhận',
                      textColor: Colors.black,
                      backgroundColor: Colors.yellow,
                      handleOnPress: () {
                        changePassword(context);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
