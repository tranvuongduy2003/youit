import 'package:flutter/material.dart';
import 'package:you_it/screens/bottom_bar/bottom_nav_bar_page.dart';

import 'package:you_it/screens/group/activity_page.dart';
import 'package:you_it/screens/group/group_chat_page.dart';
import 'package:you_it/screens/group/group_information.dart';
import 'package:you_it/screens/group/upload_file_page.dart';
import 'package:you_it/screens/profile/profile_page.dart';

import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';

class AppDrawer extends StatefulWidget {
  final String groupName;

  const AppDrawer(this.groupName);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    bool showDrawer = false;

    void callback(newValue) {
      setState(() {
        showDrawer = newValue;
      });
    }

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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Text(
                    widget.groupName,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                Button(
                  Container(
                    height: 18.08,
                    child: Image.asset(
                      'assets/images/message_circle_drawer.png',
                      color: Colors.white,
                    ),
                  ),
                  'Đoạn chat',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarPage(
                          currentWidget: GroupChatPage(callback),
                        ),
                      ),
                    );
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/bell.png'),
                  ),
                  'Hoạt động',
                  () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.bottomNavBarPage,
                    );
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/link.png'),
                  ),
                  'Tệp tin',
                  () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.bottomNavBarPage,
                    );
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/info.png'),
                  ),
                  'Thông tin',
                  () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.bottomNavBarPage,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button(
    this.icon,
    this.title,
    this.handler,
  );

  final Widget icon;
  final String title;
  final VoidCallback handler;

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
                    color: AppColors.white,
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
