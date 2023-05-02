import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../widgets/stateless/new_message.dart';
import '../config/themes/app_colors.dart';
import '../widgets/stateless/drawer_and_bottom_nav.dart';
import '../widgets/stateless/bottom_tab_bar.dart';

class SliderDrawerStateKey {
  static final GlobalKey<SliderDrawerState> keyDrawer =
      GlobalKey<SliderDrawerState>();
}

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  bool _isShowDrawer = false;

  void _openDrawer() {
    if (!SliderDrawerStateKey.keyDrawer.currentState!.isDrawerOpen) {
      SliderDrawerStateKey.keyDrawer.currentState!.openSlider();
      setState(() {
        _isShowDrawer = true;
      });
    }
  }

  void _closeDrawer() {
    if (SliderDrawerStateKey.keyDrawer.currentState!.isDrawerOpen) {
      SliderDrawerStateKey.keyDrawer.currentState!.closeSlider();
      setState(() {
        _isShowDrawer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const groupName = 'Nhóm UIT';
    int soluongMessage = 0; //dung de test

    return Scaffold(
      body: DrawerAndBottomNav(
        groupName: groupName,
        isShowDrawer: _isShowDrawer,
        openDrawer: _openDrawer,
        closeDrawer: _closeDrawer,
        chatScreen: Scaffold(
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
                          color: Color(0xFF979C9E),
                        ),
                      ),
                    ],
                  ),
                ),
              NewMessage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isShowDrawer ? BottomTabBar() : null,
      extendBody: true,
    );
  }
}
