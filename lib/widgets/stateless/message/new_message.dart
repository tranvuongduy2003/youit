import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/show_snackbar.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    super.key,
    this.groupId = '',
    this.isOneOnOneChat = false,
    this.chatId = '',
  });

  final String chatId;
  final String groupId;
  final bool isOneOnOneChat;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();
  String _enteredMessage = '';

  sendMessage() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (widget.isOneOnOneChat) {
        print(widget.chatId);
        DatabaseService(uid: user.uid).sendUserMessage(widget.chatId, {
          'text': _enteredMessage.trim(),
          'sender': userData['userName'],
          'senderId': user.uid,
          'createAt': DateTime.now(),
        });
      } else {
        DatabaseService(uid: user.uid).sendGroupMessage(widget.groupId, {
          'message': _enteredMessage.trim(),
          'sender': userData['userName'],
          'senderId': user.uid,
          'createAt': DateTime.now(),
        });
      }
      setState(() {
        _messageController.clear();
      });
    } catch (e) {
      ShowSnackbar().showSnackBar(context, AppColors.primaryColor, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      //height: 55,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          side: BorderSide(color: AppColors.startDust, width: 0.1),
        ),
        margin: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Transform.rotate(
                angle: 45 * pi / 180,
                child: IconButton(
                  icon: Icon(
                    Icons.attach_file_sharp,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 100),
                padding: EdgeInsets.symmetric(vertical: 7),
                child: TextField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    labelText: 'Nhắn tin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFE6E6E6),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _enteredMessage.trim().isEmpty ? null : sendMessage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
