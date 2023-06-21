import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/show_snackbar.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key, required this.groupId});

  final String groupId;

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  bool _isLoading = false;

  final searchController = TextEditingController();
  String searchText = '';
  Map<String, List<String>> usersSelected = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: TextButton(
          child: const Text(
            'Huỷ',
            style: AppTextStyles.appbarButtonTitle,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: AppTextStyles.sectionTitle,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser!.uid)
                    .addMembers(widget.groupId, usersSelected);
                setState(() {
                  _isLoading = false;
                });
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                ShowSnackbar().showSnackBar(context, Colors.red, e);
                setState(() {
                  _isLoading = false;
                });
              }
            },
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Thêm',
                    style: AppTextStyles.appbarButtonTitle,
                  ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.lineColor,
            height: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                'Nhập tên thành viên',
                style: AppTextStyles.mont20,
              ),
            ),
          ),
          Container(
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
              onSubmitted: (value) {
                setState(() {
                  searchText = value;
                });
              },
              controller: searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    //   size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      searchText = searchController.text;
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
          if (usersSelected.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: usersSelected.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        Text(
                          usersSelected.values.elementAt(index)[0],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('groups')
                .doc(widget.groupId)
                .get(),
            builder: (context, groupsnapshot) {
              if (groupsnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(
                '${widget.groupId}_${groupsnapshot.data!['groupName']}',
              );
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .limit(30)
                    .snapshots(),
                builder: (context, usersnapshot) {
                  if (usersnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var usersData = usersnapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: usersnapshot.data!.size,
                      itemBuilder: (ctx, index) {
                        //user co trong group thi an di
                        var groups = usersData[index]['groups'] as List;

                        if (groups.any(
                          (group) =>
                              group ==
                              '${widget.groupId}_${groupsnapshot.data!['groupName']}',
                        )) {
                          return SizedBox.shrink();
                        }
                        final isSelected =
                            usersSelected.keys.contains(usersData[index].id);
                        final userEmail = usersData[index]['email'];
                        final userName = usersData[index]['userName'];

                        //search trong thi return tat ca
                        //neu search trong hoac ten cua user co chua doan chu trong search thi return user do
                        if (searchText.isEmpty ||
                            userName
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase())) {
                          return UserCard(
                            handlerChange: () {
                              setState(() {
                                if (isSelected) {
                                  usersSelected.remove(usersData[index].id);
                                } else {
                                  usersSelected.addAll({
                                    usersData[index].id: [
                                      userName,
                                      //  usersData[index]['khoa'],
                                    ]
                                  });
                                }
                                print(usersSelected);
                              });
                            },
                            isSelected: isSelected,
                            email: userEmail,
                            userName: userName,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class UserCard extends StatefulWidget {
  UserCard({
    super.key,
    required this.isSelected,
    required this.email,
    required this.userName,
    required this.handlerChange,
  });

  final bool isSelected;
  final String userName;
  final String email;
  final VoidCallback handlerChange;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: ListTile(
        onTap: widget.handlerChange,
        trailing: isSelected
            ? Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.blue,
              )
            : Icon(
                Icons.circle_outlined,
                color: Colors.blue,
              ),
        leading: CircleAvatar(backgroundColor: Colors.red),
        title: Text(
          widget.userName,
          style: AppTextStyles.mont23_600,
        ),
        subtitle: Text(
          widget.email,
          style: AppTextStyles.emailSearch,
        ),
      ),
    );
  }
}
