import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/widgets/stateless/message/message_bubble.dart';

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
        var userId = FirebaseAuth.instance.currentUser!.uid;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }

        final chatDocs = snapshot.data!.docs;

        return Expanded(
          child: ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              final chatMessage = chatDocs[index].data();
              final nextChatMessage = index + 1 < chatDocs.length
                  ? chatDocs[index + 1].data()
                  : null;

              final currentMessageUserId = chatMessage['senderId'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['senderId'] : null;
              final nextUserIsSame = nextMessageUserId == currentMessageUserId;

              final currentUserId = FirebaseAuth.instance.currentUser!.uid;
              final bool isMe = currentMessageUserId == currentUserId;

              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: chatMessage['text'],
                  imageUrl: chatMessage['imageUrl'],
                  fileUrl: chatMessage['fileUrl'],
                  isMe: isMe,
                );
              } else {
                return MessageBubble.first(
                  userImage: chatMessage['avatar'] ?? '',
                  imageUrl: chatMessage['imageUrl'],
                  fileUrl: chatMessage['fileUrl'],
                  username: chatMessage['sender'],
                  message: chatMessage['text'],
                  isMe: isMe,
                );
              }
            },
            itemCount: chatDocs.length,
          ),
        );
      },
    );
  }
}
