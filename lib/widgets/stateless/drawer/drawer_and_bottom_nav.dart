import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'app_drawer.dart';
import '../../../config/themes/app_text_styles.dart';

class DrawerAndBottomNav extends StatelessWidget {
  DrawerAndBottomNav({
    required this.isShowDrawer,
    required this.openDrawer,
    required this.closeDrawer,
    required this.childScreen,
    required this.keyDrawer,
    required this.isShowAppBar,
    required this.groupId,
    required this.selectedIndexDrawer,
  });
  final GlobalKey<SliderDrawerState> keyDrawer;

  final bool isShowDrawer;

  final Function openDrawer;
  final Function closeDrawer;
  final Widget childScreen;
  final bool isShowAppBar;
  final String groupId;
  final int selectedIndexDrawer;

  @override
  Widget build(BuildContext context) {
    final groupFuture =
        FirebaseFirestore.instance.collection('groups').doc(groupId).get();
    String groupName;
    return SliderDrawer(
      isDraggable: false,
      appBar: isShowAppBar
          ? SliderAppBar(
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
                  // openDrawer();

                  if (!keyDrawer.currentState!.isDrawerOpen) {
                    keyDrawer.currentState!.openSlider();
                    openDrawer();
                  }
                },
              ),
              isTitleCenter: false,
              title: FutureBuilder(
                  future: groupFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    groupName = snapshot.data!['groupName'];
                    return Container(
                      constraints: BoxConstraints(maxWidth: 150),
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        groupName,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.appBarText,
                      ),
                    );
                  }),
            )
          : null,
      slider: FutureBuilder(
          future: groupFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return AppDrawer(
                snapshot.data!['groupName'], groupId, selectedIndexDrawer);
          }),
      child: GestureDetector(
        onTap: () {
          if (keyDrawer.currentState!.isDrawerOpen) {
            keyDrawer.currentState!.closeSlider();
            closeDrawer();
          }
        },
        child: childScreen,
      ),
      key: keyDrawer,
    );
  }
}
