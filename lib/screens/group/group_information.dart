import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/screens/group/add_member_page.dart';
import 'package:you_it/service/database_service.dart';

import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../screens/group/member_list_page.dart';
import '../../widgets/stateless/circle_button.dart';

class GroupInformationPage extends StatefulWidget {
  const GroupInformationPage({
    super.key,
    required this.groupId,
    // required this.groupName,
  });

  final String groupId;
//  final String groupName;

  @override
  State<GroupInformationPage> createState() => _GroupInformationPageState();
}

class _GroupInformationPageState extends State<GroupInformationPage> {
  final controller = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingScreen = false;
  CollectionReference groups = FirebaseFirestore.instance.collection('groups');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future outGroup(String userId, String userName, String groupName) async {
    setState(() {
      _isLoadingScreen = true;
    });
    DatabaseService(uid: userId)
        .outGroup(userName, widget.groupId, groupName)
        .then((value) {
      if (!value) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text(
                  'Thông báo',
                  style: AppTextStyles.mont20,
                ),
                content: Text(
                  'Quản trị viên không thể rời nhóm. Vui lòng chỉ định một quản trị viên mới.',
                  style: AppTextStyles.seenMessageTitle,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'OK',
                      style: AppTextStyles.mont20,
                    ),
                  )
                ],
              );
            });
      } else {
        Navigator.of(context)
            .pushReplacementNamed(Routes.bottomNavBarWithGroupListPage);
      }

      setState(() {
        _isLoadingScreen = false;
      });
    });
  }

  Future<void> openDialog(
    BuildContext context,
    String title,
    String content,
    String groupId,
  ) {
    controller.text = content;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              decoration: BoxDecoration(),
              width: 340,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      title,
                      style: AppTextStyles.appBarText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: controller,
                      //initialValue: content,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _isLoading
                            ? CircularProgressIndicator()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleButton(
                                      imageAsset: 'assets/images/save.png',
                                      buttonColor: Color(0xffFCFF7B),
                                      onPressed: () async {
                                        if (title == 'Mô tả') {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          groups.doc(groupId).update({
                                            'description': controller.text,
                                          }).then((value) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await DatabaseService(
                                                  uid: FirebaseAuth.instance
                                                      .currentUser!.uid)
                                              .changeGroupName(widget.groupId,
                                                  controller.text, content)
                                              .then((value) {
                                            setState(() {
                                              _isLoading = false;
                                            });

                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                      size: 55),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Lưu',
                                      style: AppTextStyles.appBarText,
                                    ),
                                  )
                                ],
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleButton(
                                imageAsset: 'assets/images/cancel.png',
                                buttonColor: Color(0xff92A8F6),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                size: 55),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Hủy',
                                style: AppTextStyles.appBarText,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingScreen
        ? Center(
            child: CircularProgressIndicator(),
          )
        : FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final currentUserId = FirebaseAuth.instance.currentUser!.uid;
              final currentUserName = futureSnapshot.data!['userName'];
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('groups')
                        .doc(widget.groupId)
                        .snapshots(),
                    builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('An Error Occur');
                      }
                      if (!snapshot.hasData) {
                        return Text('No Groups');
                      }
                      List<dynamic> members = snapshot.data!['members'];
                      String groupName = snapshot.data!['groupName'];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: AppColors.lightPink,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          groupName,
                                          style: AppTextStyles.groupName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                              color: Colors.black,
                                              Icons.person_2_outlined),
                                          Text(
                                            'Có ${members.length} thành viên',
                                            style: AppTextStyles.heading,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleButton(
                                    isImageButton: false,
                                    icon: Icon(
                                      Icons.person_add_alt_1_outlined,
                                      size: 30,
                                    ),
                                    buttonColor: AppColors.isabelline,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => AddMemberPage(
                                              groupId: widget.groupId),
                                        ),
                                      );
                                    },
                                    size: 55)
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 20, left: 40),
                              child: Text(
                                'Tên nhóm',
                                style: AppTextStyles.appBarText,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.isabelline,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width * 0.8,
                                        48),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  onPressed: () => openDialog(
                                    context,
                                    'Tên nhóm',
                                    groupName,
                                    widget.groupId,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          groupName,
                                          style: AppTextStyles.body,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Image.asset(
                                            'assets/images/edit.png'),
                                      )
                                    ],
                                  ),
                                )),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10, left: 40),
                              child: Text(
                                'Mô tả',
                                style: AppTextStyles.appBarText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.isabelline,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () => openDialog(
                                    context,
                                    'Mô tả',
                                    snapshot.data!['description'],
                                    widget.groupId),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        snapshot.data!['description'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.body,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child:
                                          Image.asset('assets/images/edit.png'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10, left: 40),
                              child: Text(
                                'Thành viên',
                                style: AppTextStyles.appBarText,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.isabelline,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width * 0.8,
                                        48),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MemberListPage(
                                        groupId: widget.groupId,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(
                                          color: Colors.black,
                                          Icons.person_2_outlined,
                                          size: 30,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          'Thành viên (${members.length})',
                                          style: AppTextStyles.sectionTitle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(
                                            color: Colors.black,
                                            Icons.arrow_forward_ios),
                                      )
                                    ],
                                  ),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: CircleButton(
                                    imageAsset: 'assets/images/out_group.png',
                                    buttonColor: Color(0xffFF9AA2),
                                    onPressed: () {
                                      outGroup(currentUserId, currentUserName,
                                          groupName);
                                    },
                                    size: 55)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            });
  }
}
