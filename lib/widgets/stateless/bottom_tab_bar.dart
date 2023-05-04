import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return

        //  Container(
        //     //  color: AppColors.pinkRed.withOpacity(0.6),
        //     width: MediaQuery.of(context).size.width * 0.6,
        //     height: 50,

        // ),
        ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        selectedItemColor: AppColors.redPigment,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(CupertinoIcons.chat_bubble),
          ),
          BottomNavigationBarItem(
            label: 'Users',
            icon: Icon(Icons.group_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Smiley',
            icon: Icon(CupertinoIcons.smiley),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
