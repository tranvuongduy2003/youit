import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/screens/general/genaral_page.dart';
import 'package:you_it/screens/group/group_page.dart';

import '../../config/themes/app_colors.dart';
import '../../screens/home/home_page.dart';
import '../../screens/message/message_page.dart';
import '../../screens/profile/profile_page.dart';
import '../../widgets/stateless/drawer/drawer_and_bottom_nav.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({
    this.currentWidget = const GroupPage(),
    required this.groupId,
    required this.groupName,
    required this.selectedIndexDrawer,
  });

  final Widget currentWidget;
  final String groupId;
  final String groupName;
  final int selectedIndexDrawer;

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int selectedIndex = 2;
  bool _isShowAppBar = true;
  bool _isShowDrawer = false;
  bool _showDrawerAndBottomNav = false;

  final GlobalKey<SliderDrawerState> keyDrawer = GlobalKey<SliderDrawerState>();
  void _openDrawer() {
    setState(() {
      _isShowDrawer = true;
      _showDrawerAndBottomNav = true;
    });
  }

  void _closeDrawer() {
    setState(() {
      _isShowDrawer = false;
      _showDrawerAndBottomNav = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget?> widgetOptions = [
      HomePage(),
      MessagePage(),
      widget.currentWidget,
      ProfilePage(userId: FirebaseAuth.instance.currentUser!.uid),
      GeneralPage(),
    ];

    return Scaffold(
      body: DrawerAndBottomNav(
        selectedIndexDrawer: widget.selectedIndexDrawer,
        groupId: widget.groupId,
        groupName: widget.groupName,
        openDrawer: _openDrawer,
        closeDrawer: _closeDrawer,
        isShowDrawer: _isShowDrawer,
        keyDrawer: keyDrawer,
        isShowAppBar: _isShowAppBar,
        childScreen: Scaffold(
          body: widgetOptions[selectedIndex],
        ),
      ),
      extendBody: false, //selectedIndex == 2 ? true : false,
      bottomNavigationBar: _showDrawerAndBottomNav
          ? ClipRRect(
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
                  setState(
                    () {
                      selectedIndex = index;
                      if (index != 2) {
                        _isShowAppBar = false;
                      } else {
                        _showDrawerAndBottomNav = false;
                        _isShowAppBar = true;
                      }
                    },
                  );
                  keyDrawer.currentState?.closeSlider();
                  _isShowDrawer = false;
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
            )
          : null,
    );
  }
}
