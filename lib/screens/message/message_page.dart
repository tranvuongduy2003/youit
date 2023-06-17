import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/input.dart';
import 'package:you_it/widgets/stateless/message/message_user.dart';
import '../../widgets/stateless/header_bar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final _searchController = TextEditingController();
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    final headerBar = HeaderBar(
      title: Text(
        'Trò chuyện',
        style: AppTextStyles.appBarText,
      ),
      handler: () => Navigator.of(context).pop(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: Text(
          'Trò chuyện',
          style: AppTextStyles.appBarText,
        ),
        handler: () => Navigator.of(context).pop(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .orderBy('lastMessageTime', descending: true)
              .snapshots(),
          builder: (context, chatssnapshot) {
            if (chatssnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (chatssnapshot.hasError) {
              print(chatssnapshot.error);
            }

            if (chatssnapshot.hasData) {
              return Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 50,
                        // width: MediaQuery.of(context).size.width * 0.7,
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 10,
                          top: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          color: AppColors.grey.withOpacity(1),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onSubmitted: (value) {
                            setState(() {
                              _searchText = value;
                            });
                          },
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                //   size: 20,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchText = _searchController.text;
                                });
                              },
                              //   color: Colors.black,
                            ),
                            hintText: 'Tìm kiếm...',
                            hintStyle: AppTextStyles.body,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: chatssnapshot.data!.size,
                        itemBuilder: (ctx, index) {
                          final data = chatssnapshot.data!.docs;

                          final participantsData = data[index]['participants']
                              as Map<String, dynamic>;

                          if (participantsData.keys.contains(currentUserId)) {
                            //tim id cua user dang nhan
                            final String otherUserId =
                                participantsData.keys.singleWhere(
                              (userId) => userId != currentUserId,
                            );

                            return FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(otherUserId)
                                    .get(),
                                builder: (context, usersnapshot) {
                                  if (usersnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  }

                                  final String otherUserName =
                                      usersnapshot.data!['userName'];

                                  if (_searchText.isEmpty ||
                                      otherUserName.toLowerCase().contains(
                                          _searchText.toLowerCase())) {
                                    //return tat ca doan chat
                                    return MessageUser(
                                      isMe: data[index]['lastSenderId'] ==
                                          currentUserId,
                                      isOnline: usersnapshot.data!['isOnline'],
                                      userId: otherUserId,
                                      chatId: data[index]['chatId'],
                                      lastMessage: data[index]['lastMessage'],
                                      userName: otherUserName,
                                      lastMessageTime: data[index]
                                          ['lastMessageTime'],
                                    );
                                  }

                                  return SizedBox.shrink();
                                });
                          }
                        }),
                  )
                ],
              );
            }
            return Container();
          }),
    );
  }
}
