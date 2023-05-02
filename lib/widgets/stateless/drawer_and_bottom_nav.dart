import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

import '../../group/group_chat_page.dart';
import '../../config/themes/app_colors.dart';
import 'app_drawer.dart';

class DrawerAndBottomNav extends StatefulWidget {
  DrawerAndBottomNav({
    required this.groupName,
    required this.isShowDrawer,
    required this.openDrawer,
    required this.closeDrawer,
    required this.chatScreen,
  });
  final bool isShowDrawer;
  final String groupName;
  final Function openDrawer;
  final Function closeDrawer;
  final Widget chatScreen;

  @override
  State<DrawerAndBottomNav> createState() => _DrawerAndBottomNavState();
}

class _DrawerAndBottomNavState extends State<DrawerAndBottomNav> {
  @override
  Widget build(BuildContext context) {
    return SliderDrawer(
      isDraggable: false,
      appBar: SliderAppBar(
        drawerIcon: IconButton(
          icon: widget.isShowDrawer ? Container() : Icon(Icons.menu),
          onPressed: () {
            widget.openDrawer();
          },
        ),
        isTitleCenter: false,
        appBarPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.groupName,
            style: AppTextStyles.appBarText,
          ),
        ),
      ),
      slider: AppDrawer(widget.groupName),
      child: GestureDetector(
        onTap: () {
          widget.closeDrawer();
        },
        child: widget.chatScreen,
      ),
      key: SliderDrawerStateKey.keyDrawer,
    );
  }
}
