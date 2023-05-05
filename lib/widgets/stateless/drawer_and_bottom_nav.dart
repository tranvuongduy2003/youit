import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

import '../../screens/group/group_chat_page.dart';
import 'app_drawer.dart';

// class SliderDrawerStateKey {
//   static final GlobalKey<SliderDrawerState> keyDrawer =
//       GlobalKey<SliderDrawerState>();
// }

class DrawerAndBottomNav extends StatelessWidget {
  DrawerAndBottomNav({
    required this.groupName,
    required this.isShowDrawer,
    required this.openDrawer,
    required this.closeDrawer,
    required this.childScreen,
    required this.keyDrawer,
  });
  final GlobalKey<SliderDrawerState> keyDrawer;

  final bool isShowDrawer;
  final String groupName;
  final Function openDrawer;
  final Function closeDrawer;
  final Widget childScreen;

  @override
  Widget build(BuildContext context) {
    return SliderDrawer(
      isDraggable: false,
      appBar: SliderAppBar(
        appBarHeight: 80,
        drawerIcon: IconButton(
          padding: EdgeInsets.only(left: 15, top: 10),
          icon: isShowDrawer
              ? Container()
              : Icon(
                  Icons.menu,
                  size: 30,
                ),
          onPressed: () {
            openDrawer();
          },
        ),
        isTitleCenter: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            groupName,
            style: AppTextStyles.appBarText,
          ),
        ),
      ),
      slider: AppDrawer(groupName),
      child: GestureDetector(
        onTap: () {
          closeDrawer();
        },
        child: childScreen,
      ),
      key: keyDrawer,
    );
  }
}
