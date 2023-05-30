import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference groupsCollection =
      FirebaseFirestore.instance.collection('groups');
  Future updateUserData(String email) async {
    return await usersCollection.doc(uid).set({
      'email': email,
      'groups': [],
      'profilePic': '',
      'uid': uid,
    });
  }
}
