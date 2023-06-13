import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';
import 'package:you_it/widgets/stateless/group/group_card.dart';
import 'package:you_it/widgets/stateless/group/group_form.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  String userName = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  String getId(String val) {
    return val.substring(0, val.indexOf('_'));
  }

  String getName(String val) {
    return val.substring(val.indexOf('_') + 1);
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return DefaultTabController(
          length: 2,
          initialIndex: selectedIndex,
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Container(
                  height: 80,
                  //width: double.infinity,
                  color: AppColors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 50,
                          // width: MediaQuery.of(context).size.width * 0.7,
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 10,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: AppColors.grey.withOpacity(1),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black,
                              ),
                              hintText: 'Tìm kiếm...',
                              hintStyle: AppTextStyles.body,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                        ),
                        child: CircleButton(
                          buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return GroupForm(
                                  userId: userId,
                                  userName: futureSnapshot.data!['userName'],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.add),
                          size: 50,
                          isImageButton: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: selectedIndex == 0
                      ? AppColors.blue.withOpacity(0.36)
                      : AppColors.primaryColor.withOpacity(0.36),
                  child: TabBar(
                    controller: _tabController,

                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: selectedIndex == 1
                            ? Radius.circular(30)
                            : Radius.zero,
                        bottomLeft: selectedIndex == 1
                            ? Radius.circular(30)
                            : Radius.zero,
                        bottomRight: selectedIndex == 0
                            ? Radius.circular(30)
                            : Radius.zero,
                        topRight: selectedIndex == 0
                            ? Radius.circular(30)
                            : Radius.zero,
                      ),
                      color: selectedIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.blue,
                    ),
                    automaticIndicatorColorAdjustment: false,
                    //indicatorColor: AppColors.primaryColor,
                    tabs: [
                      Tab(
                        child: Semantics(
                          child: Text(
                            'Tất cả các nhóm',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: selectedIndex == 0
                                  ? AppColors.redPigment
                                  : AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Nhóm của bạn',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: selectedIndex == 1
                                ? Color(0xFF051C40)
                                : AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('groups')
                      .orderBy('createAt', descending: true)
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('An Error Occur');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Text('No Groups');
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          var data = snapshot.data!.docs[index];
                          List<dynamic> membersList = data['members'];
                          bool isJoin = membersList.any((element) {
                            return element
                                .toString()
                                .contains('${userId}_$userName');
                          });
                          return selectedIndex == 1 && !isJoin
                              ? Container()
                              : GroupCard(
                                  chatMembersNum: membersList.length,
                                  admin: data['admin'],
                                  userName: userName,
                                  isJoinGroup: isJoin,
                                  groupId: data['groupId'],
                                  groupName: data['groupName'],
                                );
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
