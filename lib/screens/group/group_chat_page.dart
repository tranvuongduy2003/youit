import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/screens/home/home_page.dart';
import 'package:you_it/screens/message/message_page.dart';
import 'package:you_it/screens/profile/profile_page.dart';

import '../../widgets/stateless/new_message.dart';
import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/drawer_and_bottom_nav.dart';
import '../../widgets/stateless/bottom_tab_bar.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key});

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  bool _isShowDrawer = false;
  int _selectedIndex = 0;

  List<Widget> screens = [
    HomePage(),
    MessagePage(),
    GroupChatPage(),
    ProfilePage(),
    Center(
      child: Text('Hihi'),
    ),
  ];

  final GlobalKey<SliderDrawerState> keyDrawer = GlobalKey<SliderDrawerState>();
  void _openDrawer() {
    setState(() {
      _isShowDrawer = true;
    });
  }

  void _closeDrawer() {
    setState(() {
      _isShowDrawer = false;
    });
  }

  void onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const groupName = 'Nhóm UIT';
    int soluongMessage = 0; //dung de test

    return Scaffold(
      body: DrawerAndBottomNav(
        keyDrawer: keyDrawer,
        groupName: groupName,
        isShowDrawer: _isShowDrawer,
        openDrawer: _openDrawer,
        closeDrawer: _closeDrawer,
        childScreen: screens[_selectedIndex],
      ),
      extendBody: true,
    );
  }
}

class MessagePage2 extends StatelessWidget {
  const MessagePage2({
    super.key,
    required this.soluongMessage,
    required this.groupName,
  });

  final int soluongMessage;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (soluongMessage == 0)
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    child: FittedBox(
                      child: Text(
                        'Chào mừng đến với \n$groupName',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  Text(
                    'Hãy bắt đầu đoạn chat!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.startDust,
                    ),
                  ),
                ],
              ),
            ),
          NewMessage(),
        ],
      ),
    );
  }
}
