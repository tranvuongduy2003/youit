import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/network/client.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/show_snackbar.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    super.key,
    this.groupId = '',
    this.groupName = '',
    this.isOneOnOneChat = false,
    this.chatId = '',
  });

  final String chatId;
  final String groupId;
  final String groupName;
  final bool isOneOnOneChat;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();
  String _enteredMessage = '';
  String? _imageUrl;
  String? _fileUrl;

  sendMessage() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (widget.isOneOnOneChat) {
        DatabaseService(uid: user.uid).sendUserMessage(widget.chatId, {
          'text': _enteredMessage.trim(),
          'sender': userData['userName'],
          'imageUrl': _imageUrl,
          'fileUrl': _fileUrl,
          'avatar': userData['avatar'],
          'senderId': user.uid,
          'createAt': DateTime.now(),
        });
      } else {
        if (_imageUrl != null) {
          DatabaseService(uid: user.uid).saveDocuments({
            'groupId': widget.groupId,
            'documentUrl': _imageUrl!,
            'senderId': user.uid,
            'senderName': userData['userName'],
            'createdAt': DateTime.now(),
          });
        }
        if (_fileUrl != null) {
          DatabaseService(uid: user.uid).saveDocuments({
            'groupId': widget.groupId,
            'documentUrl': _fileUrl!,
            'senderId': user.uid,
            'senderName': userData['userName'],
            'createdAt': DateTime.now(),
          });
        }
        DatabaseService(uid: user.uid).sendGroupMessage(widget.groupId, {
          'message': _enteredMessage.trim(),
          'sender': userData['userName'],
          'imageUrl': _imageUrl,
          'fileUrl': _fileUrl,
          'avatar': userData['avatar'],
          'senderId': user.uid,
          'createAt': DateTime.now(),
        });
        Client().sendMessageToGroup(
            title: widget.groupName,
            body: _fileUrl != null
                ? 'Đã gửi một file.'
                : _imageUrl != null
                    ? 'Đã gửi một ảnh.'
                    : _enteredMessage.trim(),
            groupId: widget.groupId);
      }
      setState(() {
        _messageController.clear();
        _fileUrl = null;
        _imageUrl = null;
      });
    } catch (e) {
      ShowSnackbar().showSnackBar(context, AppColors.primaryColor, e);
    }
  }

  handleTakePhoto() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage == null) {
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${pickedImage.name}');

      print(pickedImage.path);
      await storageRef.putFile(File(pickedImage.path));
      final imageUrl = await storageRef.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });
    } catch (e) {
      print(e);
    }
  }

  handleUploadPhoto() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage == null) {
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${pickedImage.name}');

      await storageRef.putFile(File(pickedImage.path));
      final imageUrl = await storageRef.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });
    } catch (e) {
      print(e);
    }
  }

  handleUploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result == null) {
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('files')
          .child('${result.files.single.name}');

      await storageRef.putFile(File(result.files.single.path!));
      final fileUrl = await storageRef.getDownloadURL();

      setState(() {
        _fileUrl = fileUrl;
      });
    } catch (e) {
      print(e);
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
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text('Take a photo'),
                            onTap: handleTakePhoto,
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Choose a photo'),
                            onTap: handleUploadPhoto,
                          ),
                          ListTile(
                            leading: Icon(Icons.file_copy),
                            title: Text('Choose file'),
                            onTap: handleUploadFile,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 100),
                padding: EdgeInsets.symmetric(vertical: 7),
                child: _imageUrl != null
                    ? Image(image: NetworkImage(_imageUrl!))
                    : _fileUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration:
                                    BoxDecoration(color: Colors.black26),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.file_present_rounded,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'File',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        : TextField(
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
                onPressed: _enteredMessage.trim().isEmpty &&
                        _fileUrl == null &&
                        _imageUrl == null
                    ? null
                    : sendMessage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
