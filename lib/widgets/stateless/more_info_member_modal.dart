import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_text_styles.dart';
import '../../screens/message/message_detail_page.dart';
import '../../screens/profile/profile_page.dart';
import '../../service/database_service.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/text_circle_button.dart';

class MoreInfoModal extends StatefulWidget {
  const MoreInfoModal({
    super.key,
    required this.avtURL,
    required this.destinationUserId,
    required this.currentUserIsAdmin,
    required this.groupId,
  });
  final String avtURL;
  final bool currentUserIsAdmin;
  final String destinationUserId;
  final String groupId;

  @override
  State<MoreInfoModal> createState() => _MoreInfoModalState();
}

class _MoreInfoModalState extends State<MoreInfoModal> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.destinationUserId)
            .get(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                )),
            height: MediaQuery.of(context).size.height * 0.4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(widget.avtURL),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            futureSnapshot.data!['userName'],
                            style: AppTextStyles.appBarText,
                          ),
                        )
                      ],
                    ),
                  ),
                  TextCircleButton(
                    btn: CircleButton(
                        imageAsset: 'assets/images/profile.png',
                        buttonColor: Color(0xffFCFF7B),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                        userId: widget.destinationUserId,
                                      )));
                        },
                        size: 60),
                    txt: 'Xem thông tin',
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : TextCircleButton(
                          btn: CircleButton(
                              isImageButton: false,
                              icon: Icon(
                                Icons.chat_outlined,
                                size: 33,
                              ),
                              buttonColor: Color(0xff92F696),
                              onPressed: () async {
                                try {
                                  final currentUserId =
                                      FirebaseAuth.instance.currentUser!.uid;

                                  DatabaseService(uid: currentUserId)
                                      .startChat(widget.destinationUserId)
                                      .then(
                                    (chatId) {
                                      print(chatId);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => MessageDetailPage(
                                              chatId: chatId,
                                              destinationUserId:
                                                  widget.destinationUserId),
                                        ),
                                      );
                                    },
                                  );
                                } catch (e) {
                                  print(e);
                                }
                              },
                              size: 60),
                          txt: 'Trò chuyện',
                        ),
                  if (widget.currentUserIsAdmin)
                    TextCircleButton(
                      btn: CircleButton(
                          isImageButton: false,
                          icon: Icon(
                            Icons.star,
                            size: 33,
                          ),
                          buttonColor: Color(0xffFCFF7B),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              final currentUserId =
                                  FirebaseAuth.instance.currentUser!.uid;

                              await DatabaseService(uid: currentUserId)
                                  .appointedAsAdmin(
                                      widget.groupId,
                                      widget.destinationUserId,
                                      futureSnapshot.data!.data()!['userName']);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          size: 60),
                      txt: 'Chỉ định làm Admin',
                    )
                ],
              ),
            ),
          );
        });
  }
}
