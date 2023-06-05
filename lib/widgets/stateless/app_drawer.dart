import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_it/helper/helper_function.dart';

import '../../config/route/routes.dart';
import '../../screens/bottom_bar/bottom_nav_bar_page.dart';
import '../../screens/group/activity_page.dart';
import '../../screens/group/group_chat_page.dart';
import '../../screens/group/group_information.dart';
import '../../screens/group/upload_file_page.dart';
import '../../config/themes/app_colors.dart';

class AppDrawer extends StatefulWidget {
  final String groupName;
  final String groupId;

  const AppDrawer(
    this.groupName,
    this.groupId,
  );

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarPage(
                          groupId: widget.groupId,
                          groupName: widget.groupName,
                          currentWidget: GroupChatPage(
                            groupId: widget.groupId,
                            groupName: widget.groupName,
                          ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarPage(
                          groupId: widget.groupId,
                          groupName: widget.groupName,
                          currentWidget: ActivityPage(
                            groupId: widget.groupId,
                          ),
                        ),
                      ),
                      //  Routes.bottomNavBarPage,
                    );
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/link.png'),
                  ),
                  'Tệp tin',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarPage(
                          groupId: widget.groupId,
                          groupName: widget.groupName,
                          currentWidget: UploadFilePage(),
                        ),
                      ),
                    );
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/info.png'),
                  ),
                  'Thông tin',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarPage(
                          groupId: widget.groupId,
                          groupName: widget.groupName,
                          currentWidget: GroupInformationPage(
                            groupId: widget.groupId,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Button(
                  Container(
                    child: Image.asset(
                      'assets/images/users.png',
                      color: Colors.white,
                    ),
                    height: 18,
                  ),
                  'Danh sách nhóm',
                  () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.bottomNavBarWithGroupListPage,
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    HelperFunctions.saveUserLoggedInStatus(false);
                    HelperFunctions.saveUserNameSF('');
                    HelperFunctions.saveUserEmailSF('');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.logInPage, (route) => false);
                  },
                  child: Text('Log Out'),
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
