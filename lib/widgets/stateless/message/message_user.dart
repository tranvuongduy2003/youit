import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/screens/message/message_detail_page.dart';
import 'package:you_it/widgets/stateless/message/message_avatar.dart';

class MessageUser extends StatelessWidget {
  const MessageUser({
    Key? key,
    required this.lastMessage,
    required this.userName,
    required this.chatId,
    required this.lastMessageTime,
    required this.isOnline,
    required this.userId,
    required this.isMe,
    required this.userAvatar,
  });

  final String chatId;
  final String userName;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final bool isOnline;
  final String userId;
  final String userAvatar;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    DateTime lastMessTime = lastMessageTime.toDate();
    return InkWell(
      onTap: () async {
        Future.delayed(Duration(milliseconds: 100)).then(
          (value) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>
                  MessageDetailPage(chatId: chatId, destinationUserId: userId),
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            MessageAvatar(
              isOnline: isOnline,
              imageUrl: userAvatar,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: AppTextStyles.unSeenMessageTitle,
                ),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.4),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        isMe ? 'Bạn: $lastMessage' : lastMessage,
                        style: AppTextStyles.unSeenMessage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        DateTime.now().difference(lastMessTime) >
                                Duration(hours: 12)
                            ? DateFormat("'·' d 'thg' M").format(
                                lastMessTime,
                              )
                            : DateFormat('kk:mm').format(
                                lastMessTime,
                              ),
                        style: AppTextStyles.seenMessage,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: AppColors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
