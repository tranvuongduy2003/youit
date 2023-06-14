import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference groupsCollection =
      FirebaseFirestore.instance.collection('groups');

  Future updateUserData(String email, String userName) async {
    return await usersCollection.doc(uid).set({
      'userName': userName,
      'email': email,
      'groups': [],
      'profilePic': '',
      'uid': uid,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await usersCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupsCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  Future deleteTopic(String groupId, String topicId) async {
    return groupsCollection
        .doc(groupId)
        .collection('posts')
        .doc(topicId)
        .delete();
  }

  Future postingTopic(
      String topic, String content, String groupId, String userName) async {
    DocumentReference postDocumentReference =
        await groupsCollection.doc(groupId).collection('posts').add({
      'topic': topic,
      'content': content,
      'createAt': DateTime.now(),
      'updateAt': DateTime.now(),
      'creator': userName,
      'postId': '',
    });
    postDocumentReference.update({'postId': postDocumentReference.id});
  }

  Future outGroup(String userName, String groupId, String groupName) async {
    usersCollection.doc(uid).update({
      'groups': FieldValue.arrayRemove(['${groupId}_$groupName'])
    });
    groupsCollection.doc(groupId).update({
      'members': FieldValue.arrayRemove(['${uid}_$userName'])
    });
    groupsCollection.doc(groupId).get().then((snapshot) {
      List<dynamic> members = snapshot['members'];
      if (members.isEmpty) {
        groupsCollection.doc(groupId).delete();
      }
    });
  }

  Future joinGroup(String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = usersCollection.doc(uid);
    DocumentReference groupDocumentReference = groupsCollection.doc(groupId);

    await userDocumentReference.update({
      'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
    });
    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_$userName']),
    });
  }

  Future getUserGroups() async {
    return usersCollection.doc(uid).snapshots();
  }

  Future getGroups() async {
    return groupsCollection.snapshots();
  }

  Future sendMessage(
      String groupId, Map<String, dynamic> chatMessageData) async {
    groupsCollection.doc(groupId).collection('messages').add(chatMessageData);
  }

  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupsCollection.add({
      'groupName': groupName,
      'groupIcon': '',
      'admin': '${id}_$userName',
      'members': [],
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
      'createAt': DateTime.now(),
    });

    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_$userName']),
      'groupId': groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = usersCollection.doc(uid);
    return await userDocumentReference.update({
      'groups':
          FieldValue.arrayUnion(['${groupDocumentReference.id}_$groupName'])
    });
  }
}
