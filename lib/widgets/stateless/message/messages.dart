import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/widgets/stateless/message/message_tile.dart';

class Messages extends StatelessWidget {
  const Messages({super.key, required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              final chatDocs = snapshot.data!.docs[index];
              final currentUserId = FirebaseAuth.instance.currentUser!.uid;
              final bool isMe = (chatDocs['senderId'] == currentUserId);

              //   final messageTime = (chatDocs['createAt'] as Timestamp).toDate();

              print(index);
              print(chatDocs['text']);
              return Column(
                children: [
                  MessageTile(
                    isLast: index == 0,
                    messageTime: (chatDocs['createAt'] as Timestamp).toDate(),
                    isMe: isMe,
                    message: chatDocs['text'],
                    sender: chatDocs['sender'],
                  ),
                ],
              );
            },
            itemCount: snapshot.data!.size,
          ),
        );
      },
    );
  }
}
