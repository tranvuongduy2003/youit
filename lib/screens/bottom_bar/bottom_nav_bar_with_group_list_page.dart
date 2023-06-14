import 'package:flutter/material.dart';
import 'package:you_it/screens/group/group_page.dart';

import '../../config/themes/app_colors.dart';
import '../home/home_page.dart';
import '../message/message_page.dart';
import '../profile/profile_page.dart';

class BottomNavBarWithGroupListPage extends StatefulWidget {
  const BottomNavBarWithGroupListPage({super.key});

  @override
  State<BottomNavBarWithGroupListPage> createState() =>
      _BottomNavBarWithGroupListPageState();
}

class _BottomNavBarWithGroupListPageState
    extends State<BottomNavBarWithGroupListPage> {
  int selectedIndex = 2;
  final List<Widget?> widgetOptions = [
    HomePage(),
    MessagePage(),
    GroupPage(),
    ProfilePage(),
    Center(
      child: Text('Day la man hinh Setting'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgetOptions[selectedIndex],
        bottomNavigationBar: ClipRRect(
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
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
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
        ));
  }
}
