import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/screens/group/posting_page.dart';
import 'package:you_it/service/database_service.dart';

import '../../config/themes/app_text_styles.dart';
import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/post_form.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.groupId});

  final String groupId;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool isAdmin = false;

  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('groups')
            .doc(widget.groupId)
            .get(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (getId(futureSnapshot.data!['admin']) ==
              FirebaseAuth.instance.currentUser!.uid) {
            isAdmin = true;
          }
          print(getId(futureSnapshot.data!['admin']));
          print(FirebaseAuth.instance.currentUser!.uid);
          print(isAdmin);
          return Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('groups')
                    .doc(widget.groupId)
                    .collection('posts')
                    .orderBy('createAt', descending: true)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: snapshot.data!.docs.isNotEmpty
                        ? CircleButton(
                            buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                            onPressed: isAdmin
                                ? () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => PostingPage(
                                            groupId: widget.groupId),
                                      ),
                                    );
                                  }
                                : null,
                            isImageButton: false,
                            icon: Icon(Icons.add),
                          )
                        : null,
                    backgroundColor: AppColors.white,
                    body: snapshot.data!.docs.isEmpty
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Divider(
                                  thickness: 1,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 100),
                                  child: Text(
                                    'Chưa có \nhoạt động nào',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.startDust,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CircleButton(
                                  buttonColor:
                                      AppColors.jordyBlue.withOpacity(0.36),
                                  onPressed: isAdmin
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PostingPage(
                                                  groupId: widget.groupId),
                                            ),
                                          );
                                        }
                                      : null,
                                  isImageButton: false,
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Divider(
                                thickness: 1,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    var data = snapshot.data!.docs[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          margin: EdgeInsets.only(top: 5),
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Được đăng bởi:   ',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: AppColors.startDust,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '${data['creator']}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return _BuildDialog(
                                                    groupId: widget.groupId,
                                                    topic: data['topic'],
                                                    content: data['content'],
                                                    postId: data['postId'],
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            padding: EdgeInsets.only(
                                              left: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: AppColors.jordyBlue
                                                  .withOpacity(0.36),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${data['topic']}',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 124,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 25,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: Color(0xFFFFD3D3)
                                                .withOpacity(0.56),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 14),
                                          child: Text(
                                            '${data['content']}',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF9A1313),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data!.size,
                                ),
                              ),
                            ],
                          ),
                  );
                }),

            // bottomNavigationBar: _isShowDrawer ? BottomTabBar(0, (i) {}) : null,
            extendBody: true,
          );
        });
  }
}

class _BuildDialog extends StatefulWidget {
  const _BuildDialog(
      {required this.groupId,
      required this.topic,
      required this.content,
      required this.postId});

  final String groupId;
  final String topic;
  final String content;
  final String postId;

  @override
  State<_BuildDialog> createState() => _BuildDialogState();
}

class _BuildDialogState extends State<_BuildDialog> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56),
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'Chủ đề',
                    style: AppTextStyles.mont20,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.topic,
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        focusColor: AppColors.black.withOpacity(0.11)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'Nội dung',
                    style: AppTextStyles.mont20,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.content,
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
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        focusColor: AppColors.black.withOpacity(0.11)),
                    maxLines: 11,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _isLoading
                          ? CircularProgressIndicator()
                          : CircleButton(
                              buttonColor: Color(0xFFF41B1B).withOpacity(0.36),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                DatabaseService(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .deleteTopic(widget.groupId, widget.postId)
                                    .then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.pop(context);
                                });
                              },
                              isImageButton: false,
                              icon: Icon(
                                Icons.close,
                                color: Color(0xFFF41B1B),
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        //width: 119,
                        child: Text(
                          'Xóa bài viết',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF0000),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CircleButton(
                        buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        imageAsset: 'assets/images/cancel.png',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        // width: 119,

                        child: Text(
                          'Huỷ',
                          style: AppTextStyles.mont20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
