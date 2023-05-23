import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firerbaseAuth = FirebaseAuth.instance;

  //login
  Future loginWithUsernameAndPassword(String email, String password) async {
    try {
      User user = (await firerbaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
