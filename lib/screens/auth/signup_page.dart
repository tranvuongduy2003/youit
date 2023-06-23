import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/widgets/stateful/input_password.dart';
import 'package:you_it/widgets/stateless/sign_button.dart';

import '../../config/route/routes.dart';
import '../../widgets/stateless/input.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseFireStore = FirebaseFirestore.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formField = GlobalKey<FormState>();
  bool _checkPasswordMatched = false;
  bool _isEmailExist = false;
  bool _isLoading = false;
  String _fullName = '';
  String _email = '';
  String _confirmPassword = '';
  String _password = '';

  void _handleSignUp(context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formField.currentState!.validate() &&
          _password == _confirmPassword) {
        final credential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (credential.user != null) {
          CollectionReference users = _firebaseFireStore.collection('users');
          await users.doc(credential.user?.uid).set(
            {
              'userName': _fullName,
              'email': _email,
              'avatar': null,
              'groups': [],
              'khoa': null,
              'createdAt': DateTime.now(),
              'session': null,
              'address': '',
              'githubLink': '',
              'gitlabLink': '',
              'linkedin': '',
              'description': '',
              'dob': null,
              'isOnline': true,
            },
          );
        }
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed(Routes.fillInfoPage);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          _isEmailExist = true;
        });
        _formField.currentState?.validate();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final input = GlobalKey<FormState>();
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
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 80,
                      bottom: 20,
                    ), //top: 100, left 50
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
                  Text(_isEmailExist ? 'Email đã tồn tại!' : '',
                      style:
                          TextStyle(color: AppColors.redPigment, fontSize: 18)),
                  Form(
                    key: _formField,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                      child: Column(
                        children: <Widget>[
                          Input(
                            exception: '',
                            label: 'Họ và tên',
                            hintText: 'Nhập họ và tên',
                            textColor: AppColors.fade,
                            textfieldColor: AppColors.white,
                            handleChange: (value) => setState(() {
                              _fullName = value;
                            }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Input(
                            exception: r'\S+@\S+\.\S+',
                            label: 'Mail đăng nhập',
                            hintText: 'example@gm.uit.edu.vn',
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
                            handleChange: (value) {
                              setState(() {
                                _password = value;
                              });
                              if (value != _confirmPassword) {
                                setState(() {
                                  _checkPasswordMatched = false;
                                });
                              } else {
                                setState(() {
                                  _checkPasswordMatched = true;
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputPassword(
                            isConfirmed: _checkPasswordMatched,
                            exception:
                                r'^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#%&@"]).*$',
                            label: 'Nhập lại mật khẩu',
                            hintText: 'Nhập lại mật khẩu',
                            textColor: AppColors.fade,
                            textfieldColor: AppColors.white,
                            handleChange: (value) {
                              setState(() {
                                _confirmPassword = value;
                              });
                              if (_password != value) {
                                setState(() {
                                  _checkPasswordMatched = false;
                                });
                              } else {
                                setState(() {
                                  _checkPasswordMatched = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: SignButton(
                      buttonText: 'Đăng kí',
                      textColor: AppColors.white,
                      loading: _isLoading,
                      backgroundColor: AppColors.primaryColor,
                      handleOnPress: () => _handleSignUp(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
