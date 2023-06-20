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
  int _selectedIndex = 0;
  String _searchGroupName = '';
  final _searchController = TextEditingController();
  bool isUserSearch = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
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
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final userName = futureSnapshot.data!['userName'];
        return DefaultTabController(
          length: 2,
          initialIndex: _selectedIndex,
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                // SEARCH BAR
                Container(
                  padding: EdgeInsets.all(10),
                  color: AppColors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: AppColors.grey.withOpacity(1),
                          ),
                          child: TextField(
                            onSubmitted: (value) {
                              setState(() {
                                _searchGroupName = value;
                              });
                            },
                            controller: _searchController,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _searchGroupName = _searchController.text;
                                  });
                                },
                                //   color: Colors.black,
                              ),
                              hintText: 'Tìm kiếm...',
                              hintStyle: AppTextStyles.body,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CircleButton(
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
                    ],
                  ),
                ),

                // TAB BAR
                Material(
                  color: _selectedIndex == 0
                      ? AppColors.blue.withOpacity(0.36)
                      : AppColors.primaryColor.withOpacity(0.36),
                  child: TabBar(
                    controller: _tabController,

                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: _selectedIndex == 1
                            ? Radius.circular(30)
                            : Radius.zero,
                        bottomLeft: _selectedIndex == 1
                            ? Radius.circular(30)
                            : Radius.zero,
                        bottomRight: _selectedIndex == 0
                            ? Radius.circular(30)
                            : Radius.zero,
                        topRight: _selectedIndex == 0
                            ? Radius.circular(30)
                            : Radius.zero,
                      ),
                      color: _selectedIndex == 0
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
                              fontSize: 16,
                              fontWeight: _selectedIndex == 0
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: _selectedIndex == 0
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
                            fontSize: 16,
                            fontWeight: _selectedIndex == 1
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: _selectedIndex == 1
                                ? Color(0xFF051C40)
                                : AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // GROUP LIST
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
                      return Text('No Groups Found');
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

                          if (_searchGroupName.isEmpty ||
                              (data['groupName']
                                  .toString()
                                  .toLowerCase()
                                  .contains(_searchGroupName.toLowerCase()))) {
                            if (_selectedIndex == 0 ||
                                _selectedIndex == 1 && isJoin) {
                              return GroupCard(
                                chatMembersNum: membersList.length,
                                admin: data['admin'],
                                userName: userName,
                                isJoinGroup: isJoin,
                                groupId: data['groupId'],
                                groupName: data['groupName'],
                              );
                            }
                          }
                          return Container();
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
