import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';
import 'package:you_it/widgets/stateless/message/messages.dart';
import 'package:you_it/widgets/stateless/message/new_message.dart';

class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage({
    Key? key,
    required this.chatId,
    required this.destinationUserId,
  }) : super(key: key);

  final String chatId;
  final String destinationUserId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(destinationUserId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = snapshot.data!.data()! as Map<String, dynamic>;
        return Scaffold(
          appBar: HeaderBar(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data['userName'],
                      style: AppTextStyles.appBarText,
                    ),
                  ],
                ),
                Text(
                  data['isOnline'] ? 'Online' : 'Offline',
                  style: AppTextStyles.labelTextField,
                )
              ],
            ),
            handler: () => Navigator.of(context).pop(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Messages(chatId: chatId),
              NewMessage(
                isOneOnOneChat: true,
                chatId: chatId,
              )
            ],
          ),
        );
      },
    );
  }
}
