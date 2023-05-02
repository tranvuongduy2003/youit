import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  Icon(
                    FontAwesomeIcons.comment,
                    color: AppColors.white,
                  ),
                  'Đoạn chat',
                  () {},
                ),
                Button(
                  Icon(
                    FontAwesomeIcons.bell,
                    color: AppColors.white,
                  ),
                  'Hoạt động',
                  () {},
                ),
                Button(
                  Icon(
                    FontAwesomeIcons.link,
                    color: AppColors.white,
                    size: 20,
                  ),
                  'Tệp tin',
                  () {},
                ),
                Button(
                  Icon(
                    Icons.info_outline,
                    color: AppColors.white,
                  ),
                  'Thông tin',
                  () {},
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

  final Icon icon;
  final String title;
  final VoidCallback handler;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                icon,
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
