import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/screens/bottom_bar/bottom_nav_bar_page.dart';
import 'package:you_it/screens/group/group_chat_page.dart';

class GroupCard extends StatefulWidget {
  final String groupName;
  final String groupId;
  final bool isJoinGroup;
  final String userName;
  final String admin;
  final int chatMembersNum;

  GroupCard({
    super.key,
    required this.groupId,
    required this.groupName,
    this.isJoinGroup = false,
    required this.userName,
    required this.admin,
    required this.chatMembersNum,
  });

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  Future joinGroup(
      String userId, String groupId, String userName, String groupName) async {
    setState(() {
      isLoading = true;
    });
    DocumentReference userDocumentReference =
        FirebaseFirestore.instance.collection('users').doc(userId);
    DocumentReference groupDocumentReference =
        FirebaseFirestore.instance.collection('groups').doc(groupId);

    await userDocumentReference.update({
      'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
    });
    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(['${userId}_$userName']),
    });
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        shape: RoundedRectangleBorder(),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          leading: CircleAvatar(
            radius: 30,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Container(
            constraints: BoxConstraints(maxWidth: 100),
            child: Text(
              widget.groupName,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ),
          subtitle: Row(
            children: [
              Icon(Icons.person_outline),
              Text(
                'Có ${widget.chatMembersNum} thành viên',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          trailing: isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text(
                    widget.isJoinGroup ? 'Truy cập' : 'Tham Gia',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: widget.isJoinGroup
                          ? Color(0xFF051C40)
                          : Color(0xFFF12424),
                    ),
                  ),
                  onPressed: () async {
                    if (!widget.isJoinGroup) {
                      joinGroup(FirebaseAuth.instance.currentUser!.uid,
                          widget.groupId, widget.userName, widget.groupName);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => BottomNavBarPage(
                            selectedIndexDrawer: 0,
                            //  groupName: widget.groupName,
                            groupId: widget.groupId,
                            currentWidget: GroupChatPage(
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      widget.isJoinGroup
                          ? AppColors.lightBlue
                          : AppColors.primaryColor,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
