import 'dart:math';

import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateful/groupListButton.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';
import 'package:you_it/widgets/stateless/groupCard.dart';
import 'package:you_it/widgets/stateless/groupForm.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  List groupList = [
    ['Nhom 1', false],
    ['UITTogether', false],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void createNewGroup() {
      setState(() {
        groupList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
    }

    void createGroup() => showDialog(
          context: context,
          builder: (BuildContext context) {
            return GroupForm(
              controller: _controller,
              onCreate: createNewGroup,
              onCancel: () => Navigator.of(context).pop(),
            );
          },
        );

    void entryGroup(bool value, int index) {
      setState(() {
        groupList[index][1] = !groupList[index][1];
      });
    }

    return DefaultTabController(
      length: 2,
      initialIndex: selectedIndex,
      child: Scaffold(
        body: SingleChildScrollView(
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
                        height: 45,
                        // width: MediaQuery.of(context).size.width * 0.7,
                        margin: EdgeInsets.only(left: 20, right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          color: AppColors.grey.withOpacity(1),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onChanged: null,
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
                      padding: const EdgeInsets.only(right: 12),
                      child: CircleButton(
                        buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        size: 40,
                        isImageButton: false,
                      ),
                    ),
                    // Container(
                    //   height: 45,
                    //   width: 45,
                    //   child: ElevatedButton(
                    //     onPressed: () => {createGroup()},
                    //     style: ButtonStyle(
                    //       alignment: Alignment.center,
                    //       backgroundColor: MaterialStateProperty.all(
                    //         AppColors.lightBlue.withOpacity(1),
                    //       ),
                    //       shape: MaterialStateProperty.all(
                    //         RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(45),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Icon(
                    //       Icons.add,
                    //       color: Colors.black,
                    //       size: 16,
                    //     ),
                    //   ),
                    // ),
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
                      // icon: Container(
                      //   height: 46,
                      //   width: 200,
                      //   color: AppColors.primaryColor.withOpacity(0.36),
                      // ),
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
              Container(
                height: 2000,
                color: AppColors.white,
                child: ListView.builder(
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    return GroupCard(
                      groupName: groupList[index][0],
                      isJoinGroup: groupList[index][1],
                      onChanged: (value) => entryGroup,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
