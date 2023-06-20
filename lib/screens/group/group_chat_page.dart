import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/message/message_bubble.dart';
import '../../widgets/stateless/message/new_message.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({
    required this.groupId,
    required this.groupName,
  });

  final String groupId;
  final String groupName;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final GlobalKey<SliderDrawerState> keyDrawer = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MessageWidget(groupName: widget.groupName, groupId: widget.groupId),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.groupName,
    required this.groupId,
  });

  final String groupName;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupId)
                  .collection('messages')
                  .limit(30)
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
                print(chatDocs[0].data());

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: chatDocs.isEmpty
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      chatDocs.isEmpty
                          ? NoMessageWidget(groupName: groupName)
                          : Expanded(
                              child: ListView.builder(
                                reverse: true,
                                itemBuilder: (ctx, index) {
                                  final chatMessage = chatDocs[index].data();
                                  final nextChatMessage =
                                      index + 1 < chatDocs.length
                                          ? chatDocs[index + 1].data()
                                          : null;

                                  final currentMessageUserId =
                                      chatMessage['senderId'];
                                  final nextMessageUserId =
                                      nextChatMessage != null
                                          ? nextChatMessage['senderId']
                                          : null;
                                  final nextUserIsSame =
                                      nextMessageUserId == currentMessageUserId;

                                  if (nextUserIsSame) {
                                    return MessageBubble.next(
                                      message: chatMessage['message'],
                                      imageUrl: chatMessage['imageUrl'],
                                      fileUrl: chatMessage['fileUrl'],
                                      isMe: authenticatedUser.uid ==
                                          currentMessageUserId,
                                    );
                                  } else {
                                    return MessageBubble.first(
                                      userImage: chatMessage['avatar'] ?? "",
                                      imageUrl: chatMessage['imageUrl'],
                                      fileUrl: chatMessage['fileUrl'],
                                      username: chatMessage['sender'],
                                      message: chatMessage['message'],
                                      isMe: authenticatedUser.uid ==
                                          currentMessageUserId,
                                    );
                                  }

                                  // bool isMe = false;

                                  // if (chatDocs[index]['senderId'] == userId) {
                                  //   isMe = true;
                                  // }
                                  // return MessageTile(
                                  //   isLast: index == 0,
                                  //   messageTime: (chatDocs[index]['createAt']
                                  //           as Timestamp)
                                  //       .toDate(),
                                  //   isMe: isMe,
                                  //   message: chatDocs[index]['message'],
                                  //   sender: chatDocs[index]['sender'],
                                  // );
                                },
                                itemCount: chatDocs.length,
                              ),
                            ),
                      NewMessage(groupId: groupId),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

class NoMessageWidget extends StatelessWidget {
  const NoMessageWidget({
    super.key,
    required this.groupName,
  });

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: FittedBox(
              child: Text(
                'Chào mừng đến với \n$groupName',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ),
          ),
          Text(
            'Hãy bắt đầu đoạn chat!',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.startDust,
            ),
          ),
        ],
      ),
    );
  }
}
