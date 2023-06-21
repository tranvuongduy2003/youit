import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../widgets/stateless/message/message_tile.dart';

import '../../widgets/stateless/message/new_message.dart';
import '../../config/themes/app_colors.dart';

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                  final chatDocs = snapshot.data!.docs;
                  return Container(
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
                                    bool isMe = false;

                                    if (chatDocs[index]['senderId'] == userId) {
                                      isMe = true;
                                    }
                                    return MessageTile(
                                        isLast: index == 0,
                                        messageTime: (chatDocs[index]
                                                ['createAt'] as Timestamp)
                                            .toDate(),
                                        isMe: isMe,
                                        message: chatDocs[index]['message'],
                                        sender: chatDocs[index]['sender']);
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
      ),
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
