import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar(this.selectedIndex, this.onTap);

  final int selectedIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        //selectedItemColor: Colors.red,
        selectedItemColor: Colors.red,
        unselectedItemColor: AppColors.startDust,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageIcon(
              AssetImage('assets/images/home.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: ImageIcon(
              AssetImage('assets/images/message_circle.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Users',
            icon: ImageIcon(
              AssetImage('assets/images/users.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Smiley',
            icon: ImageIcon(
              AssetImage('assets/images/smiley.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
