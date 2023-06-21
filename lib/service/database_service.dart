import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference groupsCollection =
      FirebaseFirestore.instance.collection('groups');

  final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

  Future updateUserData(String email, String userName) async {
    return await usersCollection.doc(uid).set({
      'userName': userName,
      'email': email,
      'groups': [],
      'profilePic': '',
      'uid': uid,
    });
  }

  Future updateDescription(String description) async {
    return await usersCollection.doc(uid).update({
      'description': description,
    });
  }

  Future updateUserLinkData(
      String githubLink, String gitlabLink, String linkedin) async {
    return await usersCollection.doc(uid).update({
      'githubLink': githubLink,
      'gitlabLink': gitlabLink,
      'linkedin': linkedin,
    });
  }

  Future setUserOnlineStatus(bool onlineStatus) async {
    return await usersCollection.doc(uid).update({'isOnline': onlineStatus});
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

  Future<bool> outGroup(
      String userName, String groupId, String groupName) async {
    DocumentReference groupDocumentReference = groupsCollection.doc(groupId);
    DocumentSnapshot groupSnapshot = await groupDocumentReference.get();

    List<dynamic> members = groupSnapshot['members'] as List<dynamic>;

    //neu so luong thanh vien lon hon 1 va user hien tai la admin thi return false
    if (members.length > 1 &&
        '${uid}_$userName' == groupSnapshot['admin'].toString()) {
      return false;
    }

    await usersCollection.doc(uid).update({
      'groups': FieldValue.arrayRemove(['${groupId}_$groupName'])
    });
    await groupDocumentReference.update({
      'members': FieldValue.arrayRemove(['${uid}_$userName'])
    });
    //cap nhat lai members
    groupSnapshot = await groupDocumentReference.get();
    members = groupSnapshot['members'] as List<dynamic>;
    print(members);
    if (members.isEmpty) {
      groupDocumentReference.delete();
    }
    return true;
  }

  Future joinGroup(
      String userId, String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = usersCollection.doc(userId);
    DocumentReference groupDocumentReference = groupsCollection.doc(groupId);

    await userDocumentReference.update({
      'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
    });
    return await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(['${userId}_$userName']),
    });
  }

  Future getUserGroups() async {
    return usersCollection.doc(uid).snapshots();
  }

  Future getGroups() async {
    return groupsCollection.snapshots();
  }

  Future sendGroupMessage(
      String groupId, Map<String, dynamic> chatMessageData) async {
    await groupsCollection
        .doc(groupId)
        .collection('messages')
        .add(chatMessageData);
  }

  Future updateUserInfoData(String fullName, String department, int session,
      String address, DateTime birthDay) async {
    return await usersCollection.doc(uid).update({
      'userName': fullName,
      'khoa': department,
      'session': session,
      'address': address,
      'dob': birthDay,
    });
  }

  Future sendUserMessage(
      String chatId, Map<String, dynamic> chatMessageData) async {
    await chatsCollection
        .doc(chatId)
        .collection('messages')
        .add(chatMessageData);

    String text = chatMessageData['text'];
    await chatsCollection.doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': DateTime.now(),
      'lastSenderId': chatMessageData['senderId'],
    });
  }

  Future<bool> isChatRoomAvaiable(String destinationUserId) async {
    final chatRoom = await chatsCollection
        .where('participants', arrayContains: [uid, destinationUserId]).get();
    return chatRoom.docs.isNotEmpty;
  }

  Future appointedAsAdmin(String groupId, String destinationUserId,
      String destinationUserName) async {
    return await groupsCollection
        .doc(groupId)
        .update({'admin': '${destinationUserId}_$destinationUserName'});
  }

  Future<String> startChat(String destinationUserId) async {
    try {
      QuerySnapshot querySnapshot = await chatsCollection
          .where(
            'participants.$uid',
            isEqualTo: true,
          )
          .where(
            'participants.$destinationUserId',
            isEqualTo: true,
          )
          .get();
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        //chat room exist, create chat room

        return querySnapshot.docs.first.id;
      } else {
        //chat room doesn't exist, join chat room
        DocumentReference chatDocumentReference = chatsCollection.doc();
        await chatDocumentReference.set({
          'participants': {
            uid: true,
            destinationUserId: true,
          },
          'chatId': chatDocumentReference.id,
          'lastMessage': '',
          'timestamp': FieldValue.serverTimestamp(),
        });
        await usersCollection.doc(uid).update({
          'chats': FieldValue.arrayUnion([chatDocumentReference.id]),
        });

        return chatDocumentReference.id;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future createChatRoom(String destinationUserId) async {
    await chatsCollection.doc().set({
      'participants': [uid, destinationUserId],
    });
  }

  Future<String> getChatId(String destinationUserId) async {
    final chatQuerySnapshot = await chatsCollection
        .where('participants', arrayContains: [uid, destinationUserId]).get();
    if (chatQuerySnapshot.docs.isNotEmpty) {
      return chatQuerySnapshot.docs.first.id;
    } else {
      return '';
    }
  }

  Future addMembers(
      String groupId, Map<String, List<String>> usersSelected) async {
    var snapshot = await groupsCollection.doc(groupId).get();
    String groupName = snapshot.get('groupName');
    print(groupName);
    return usersSelected.forEach((userId, inforList) async {
      await joinGroup(userId, groupId, inforList[0], groupName);
    });
  }

  Future changeGroupName(
      String groupId, String newGroupName, String oldGroupName) async {
    DocumentReference groupDocumentReference = groupsCollection.doc(groupId);
    groupDocumentReference.update({
      'groupName': newGroupName,
    });

    QuerySnapshot members = await usersCollection
        .where('groups', arrayContains: '${groupId}_$oldGroupName')
        .get();
    for (var member in members.docs) {
      await usersCollection.doc(member.id).update({
        'groups': FieldValue.arrayRemove(['${groupId}_$oldGroupName'])
      });
      await usersCollection.doc(member.id).update({
        'groups': FieldValue.arrayUnion(['${groupId}_$newGroupName'])
      });
    }
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
