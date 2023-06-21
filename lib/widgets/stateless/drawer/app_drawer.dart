import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/service/database_service.dart';

import '../../../config/route/routes.dart';
import '../../../screens/bottom_bar/bottom_nav_bar_page.dart';
import '../../../screens/group/activity_page.dart';
import '../../../screens/group/group_chat_page.dart';
import '../../../screens/group/group_information.dart';
import '../../../screens/group/upload_file_page.dart';
import '../../../config/themes/app_colors.dart';

class AppDrawer extends StatefulWidget {
  final String groupName;
  final String groupId;
  final int selectedIndexDrawer;

  const AppDrawer(
    this.groupName,
    this.groupId,
    this.selectedIndexDrawer,
  );

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String> menuItems = [
    'Đoạn chat',
    'Hoạt động',
    'Tệp tin',
    'Thông tin',
    'Danh sách nhóm',
  ];
  List<String> iconMenuItems = [
    'assets/images/message_circle_drawer.png',
    'assets/images/bell.png',
    'assets/images/link.png',
    'assets/images/info.png',
    'assets/images/users.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      elevation: 0,
      child: Container(
        color: AppColors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.pinkRed,
                  AppColors.pinkRed.withOpacity(0.62),
                ],
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 30,
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 150),
                      child: Text(
                        widget.groupName,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: menuItems.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.36),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                selected: index == widget.selectedIndexDrawer,
                                onTap: () {
                                  setState(() {});
                                  switch (index) {
                                    case 0:
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBarPage(
                                            selectedIndexDrawer: 0,
                                            groupId: widget.groupId,
                                            // groupName: widget.groupName,
                                            currentWidget: GroupChatPage(
                                              groupId: widget.groupId,
                                              groupName: widget.groupName,
                                            ),
                                          ),
                                        ),
                                      );
                                      break;
                                    case 1:
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBarPage(
                                            selectedIndexDrawer: 1,
                                            groupId: widget.groupId,
                                            // groupName: widget.groupName,
                                            currentWidget: ActivityPage(
                                              groupId: widget.groupId,
                                            ),
                                          ),
                                        ),
                                        //  Routes.bottomNavBarPage,
                                      );
                                      break;
                                    case 2:
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBarPage(
                                            selectedIndexDrawer: 2,
                                            groupId: widget.groupId,
                                            //    groupName: widget.groupName,
                                            currentWidget: UploadFilePage(),
                                          ),
                                        ),
                                      );
                                      break;
                                    case 3:
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBarPage(
                                            selectedIndexDrawer: 3,
                                            groupId: widget.groupId,
                                            //    groupName: widget.groupName,
                                            currentWidget: GroupInformationPage(
                                              groupId: widget.groupId,
                                            ),
                                          ),
                                        ),
                                      );
                                      break;
                                    case 4:
                                      Navigator.pushReplacementNamed(
                                        context,
                                        Routes.bottomNavBarWithGroupListPage,
                                      );
                                      break;
                                  }
                                },
                                selectedColor: Colors.red,
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 0,
                                ),
                                leading: ImageIcon(
                                  AssetImage(
                                    iconMenuItems[index],
                                  ),
                                ),
                                title: Text(
                                  menuItems[index],
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        // } [
                        //   Container(
                        //     margin: EdgeInsets.symmetric(horizontal: 20),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(20),
                        //       ),
                        //       color: Colors.white.withOpacity(0.36),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child:
                        //     ),
                        //   ),
                        //   Button(
                        //       Container(
                        //         height: 18.08,
                        //         child: Image.asset(
                        //           'assets/images/message_circle_drawer.png',
                        //           color: _selectedIndexDrawer == 0
                        //               ? Colors.red
                        //               : AppColors.white,
                        //         ),
                        //       ),
                        //       'Đoạn chat', () {
                        //     _selectedIndexDrawer = 0;
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => BottomNavBarPage(
                        //           groupId: widget.groupId,
                        //           groupName: widget.groupName,
                        //           currentWidget: GroupChatPage(
                        //             groupId: widget.groupId,
                        //             groupName: widget.groupName,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   }, _selectedIndexDrawer == 0 ? Colors.red : AppColors.white),
                        //   Button(
                        //       Container(
                        //         child: Image.asset('assets/images/bell.png'),
                        //       ),
                        //       'Hoạt động', () {
                        //     _selectedIndexDrawer = 1;
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => BottomNavBarPage(
                        //           groupId: widget.groupId,
                        //           groupName: widget.groupName,
                        //           currentWidget: ActivityPage(
                        //             groupId: widget.groupId,
                        //           ),
                        //         ),
                        //       ),
                        //       //  Routes.bottomNavBarPage,
                        //     );
                        //   }, _selectedIndexDrawer == 1 ? Colors.red : AppColors.white),
                        //   Button(
                        //       Container(
                        //         child: Image.asset('assets/images/link.png'),
                        //       ),
                        //       'Tệp tin', () {
                        //     _selectedIndexDrawer = 2;
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => BottomNavBarPage(
                        //           groupId: widget.groupId,
                        //           groupName: widget.groupName,
                        //           currentWidget: UploadFilePage(),
                        //         ),
                        //       ),
                        //     );
                        //   }, _selectedIndexDrawer == 2 ? Colors.red : AppColors.white),
                        //   Button(
                        //       Container(
                        //         child: Image.asset('assets/images/info.png'),
                        //       ),
                        //       'Thông tin', () {
                        //     _selectedIndexDrawer = 3;
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => BottomNavBarPage(
                        //           groupId: widget.groupId,
                        //           groupName: widget.groupName,
                        //           currentWidget: GroupInformationPage(
                        //             groupId: widget.groupId,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   }, _selectedIndexDrawer == 3 ? Colors.red : AppColors.white),
                        //   Button(
                        //       Container(
                        //         child: Image.asset(
                        //           'assets/images/users.png',
                        //           color: Colors.white,
                        //         ),
                        //         height: 18,
                        //       ),
                        //       'Danh sách nhóm', () {
                        //     _selectedIndexDrawer = 4;
                        //     Navigator.pushReplacementNamed(
                        //       context,
                        //       Routes.bottomNavBarWithGroupListPage,
                        //     );
                        //   }, _selectedIndexDrawer == 4 ? Colors.red : AppColors.white),
                        // ],
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button(this.icon, this.title, this.handler, this.color);

  final Widget icon;
  final String title;
  final VoidCallback handler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.36),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: handler,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: icon,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
