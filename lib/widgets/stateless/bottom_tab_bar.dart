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
        //selectedItemColor: Colors.red,
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Container(
              height: 23,
              child: Image.asset('assets/images/home.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Container(
              height: 23,
              child: Image.asset('assets/images/message_circle.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Users',
            icon: Container(
              height: 23,
              child: Image.asset('assets/images/users.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Smiley',
            icon: Container(
              height: 23,
              child: Image.asset('assets/images/smiley.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(
              Icons.menu,
              size: 30,
              color: AppColors.startDust.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
