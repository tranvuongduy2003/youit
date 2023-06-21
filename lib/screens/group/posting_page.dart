import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/network/client.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../widgets/stateless/header_bar.dart';

class PostingPage extends StatefulWidget {
  const PostingPage(
      {super.key, required this.groupId, required this.groupName});

  final String groupId;
  final String groupName;

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  bool _isLoading = false;
  final topicController = TextEditingController();
  final contentController = TextEditingController();
  Future posting(String topic, String content, String userName) async {
    setState(() {
      _isLoading = true;
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .postingTopic(topic, content, widget.groupId, userName)
        .then((value) => Navigator.of(context).pop());

    Client().sendMessageToGroup(
      title: 'Thông báo: ${topic} (${widget.groupName})',
      body: content,
      groupId: widget.groupId,
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: HeaderBar(
                title: Text(
                  'Đăng bài viết',
                  style: AppTextStyles.appBarText,
                ),
                handler: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: AppColors.white,
              resizeToAvoidBottomInset: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Text(
                          'Chủ đề',
                          style: AppTextStyles.mont20,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: topicController,
                          style: AppTextStyles.postingInput,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.black.withOpacity(0.11),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              focusColor: AppColors.black.withOpacity(0.11)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Text(
                          'Nội dung',
                          style: AppTextStyles.mont20,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: contentController,
                          style: AppTextStyles.postingInput,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.black.withOpacity(0.11),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              focusColor: AppColors.black.withOpacity(0.11)),
                          maxLines: 11,
                          onSubmitted: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(111),
                        topRight: Radius.circular(111),
                      ),
                      //color: //Color(0xFFFFFCFC),
                      color: Color(0xFFFFFCFC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              CircleButton(
                                buttonColor:
                                    Color(0xFFFCFF7B).withOpacity(0.39),
                                onPressed: () {
                                  posting(
                                      topicController.text,
                                      contentController.text,
                                      futureSnapshot.data!['userName']);
                                },
                                imageAsset: ('assets/images/upload.png'),
                                size: 55,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Đăng bài',
                                style: AppTextStyles.mont20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CircleButton(
                                buttonColor:
                                    AppColors.jordyBlue.withOpacity(0.36),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                imageAsset: 'assets/images/cancel.png',
                                size: 55,
                              ),
                              SizedBox(height: 5),
                              Text('Huỷ', style: AppTextStyles.mont20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
