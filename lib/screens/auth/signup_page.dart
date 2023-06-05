import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = 'hoanganh4@gmail.com';
  String _password = '123456';
  String _userName = 'hoanganh4';

  void _handleSignUp() async {
    try {
      final credential = await _firebase.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print(credential.user);
      if (credential != null) {
        await DatabaseService(uid: credential.user!.uid)
            .updateUserData(_email, _userName);
        print('hi');
      }
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
                  handleOnPress: _handleSignUp,
                ),
                SignButton(
                  buttonText: 'Đăng nhập',
                  textColor: AppColors.primaryColor,
                  backgroundColor: AppColors.white,
                  handleOnPress: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
