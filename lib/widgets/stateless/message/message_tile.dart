import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.isMe,
    required this.message,
    required this.sender,
    required this.messageTime,
    required this.isLast,
  });

  final bool isMe;
  final bool isLast;
  final String sender;
  final String message;
  final DateTime messageTime;

  @override
  Widget build(BuildContext context) {
    String messageTimeText = '';
    final diff = DateTime.now().difference(messageTime);
    if (diff.inMinutes <= 2) {
      messageTimeText = 'Vừa xong';
    } else if (diff.inMinutes < 60) {
      messageTimeText =
          DateFormat("${diff.inMinutes} 'phút trước'").format(messageTime);
    } else if (diff.inHours < 5) {
      messageTimeText =
          DateFormat("${diff.inHours} 'giờ trước'").format(messageTime);
    } else if (diff.inHours < 12) {
      messageTimeText = DateFormat('kk:mm').format(messageTime);
    } else {
      messageTimeText = DateFormat("dd 'thg' M").format(messageTime);
    }
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isMe
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 8),
                    child: CircleAvatar(
                      radius: 20,
                      child: Text(
                        sender.toString().substring(0, 1).toUpperCase(),
                      ),
                    ),
                  ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMe
                      ? Container()
                      : Text(
                          sender,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: isMe ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12,
                        ),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            !isMe ? Radius.circular(0) : Radius.circular(12),
                        bottomRight:
                            isMe ? Radius.circular(0) : Radius.circular(12),
                      ),
                      color: isMe ? Color(0xFFF57C7C) : Color(0xFFF9BEBE),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (isLast)
          Padding(
            padding:
                isMe ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 60),
            child: Text(messageTimeText),
          ),
      ],
    );
  }
}
