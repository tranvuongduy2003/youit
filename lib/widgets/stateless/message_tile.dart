import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key,
      required this.isMe,
      required this.message,
      required this.sender});

  final bool isMe;
  final String sender;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
    );
    ;
  }
}
