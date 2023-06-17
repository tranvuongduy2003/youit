import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../service/database_service.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/header_bar.dart';
import '../../widgets/stateless/more_info_member_modal.dart';
import '../../widgets/stateless/delete_member_modal_button.dart';

class MemberListPage extends StatefulWidget {
  MemberListPage({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  String avtURL =
      'https://media.istockphoto.com/id/1387522045/vi/anh/m%C3%A8o-x%C3%A1m-l%E1%BB%9Bn-v%C3%A0-nghi%C3%AAm-t%C3%BAc.jpg?s=612x612&w=0&k=20&c=xoWOttW9yoWSWk-ju-CwdDeygkyrCVClytGobWE4aZA=';
  bool userIsAdmin = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .doc(widget.groupId)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<dynamic> members = snapshot.data!['members'];
          String adminId = getId(snapshot.data!['admin']);
          String userId = FirebaseAuth.instance.currentUser!.uid;
          if (userId == adminId) {
            userIsAdmin = true;
          }

          return Scaffold(
            appBar: HeaderBar(
                title: Text(
                  'Thành viên',
                  style: AppTextStyles.appBarText,
                ),
                handler: Navigator.of(context).pop),
            body: Container(
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Color(0xffF4F087),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(avtURL),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                //  alignment: Alignment.centerLeft,
                                child: Text(
                                  getName(members[index]),
                                  style: AppTextStyles.unSeenMessage,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              if (getId(members[index]) == adminId)
                                Icon(Icons.star_outline),
                            ],
                          ),
                          if (userId != getId(members[index]))
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: userIsAdmin
                                      ? CircleButton(
                                          buttonColor: AppColors.pinkRed,
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return DeleteMemberModal(
                                                    groupId: widget.groupId,
                                                    groupName: snapshot
                                                        .data!['groupName'],
                                                    userDeleteId:
                                                        getId(members[index]),
                                                    userDeleteName:
                                                        getName(members[index]),
                                                  );
                                                });
                                          },
                                          size: 40,
                                          isImageButton: false,
                                          icon: Icon(Icons.close),
                                        )
                                      : null,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: CircleButton(
                                    buttonColor: Color(0xff92A8F6),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return MoreInfoModal(
                                              destinationUserId:
                                                  getId(members[index]),
                                              avtURL: avtURL,
                                            );
                                          });
                                    },
                                    size: 40,
                                    isImageButton: false,
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: members.length,
              ),
            ),
          );
        });
  }
}
