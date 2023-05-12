import 'package:flutter/material.dart';

import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';

class AppDrawer extends StatelessWidget {
  final String groupName;

  const AppDrawer(this.groupName);

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
                    groupName,
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
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.groupChatPage);
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/bell.png'),
                  ),
                  'Hoạt động',
                  () {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.activityPage);
                    Navigator.canPop(context);
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/link.png'),
                  ),
                  'Tệp tin',
                  () {
                    Navigator.of(context).pushNamed(Routes.uploadFilePage);
                  },
                ),
                Button(
                  Container(
                    child: Image.asset('assets/images/info.png'),
                  ),
                  'Thông tin',
                  () {
                    Navigator.of(context)
                        .pushNamed(Routes.groupInformationPage);
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
