import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/config/route/routes.dart';

import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/drawer_and_bottom_nav.dart';
import '../../widgets/stateless/bottom_tab_bar.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool _isShowDrawer = false;
  final GlobalKey<SliderDrawerState> keyDrawer = GlobalKey<SliderDrawerState>();
  void _openDrawer() {
    if (!keyDrawer.currentState!.isDrawerOpen) {
      keyDrawer.currentState!.openSlider();
      setState(() {
        _isShowDrawer = true;
      });
    }
  }

  void _closeDrawer() {
    if (keyDrawer.currentState!.isDrawerOpen) {
      keyDrawer.currentState!.closeSlider();
      setState(() {
        _isShowDrawer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const groupName = 'Nhóm UIT';

    return Scaffold(
      // appBar: AppBar(
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(1.0),
      //     child: Container(
      //       color: AppColors.lineColor,
      //       height: 1.0,
      //     ),
      //   ),
      // ),
      body: DrawerAndBottomNav(
        keyDrawer: keyDrawer,
        groupName: groupName,
        isShowDrawer: _isShowDrawer,
        openDrawer: _openDrawer,
        closeDrawer: _closeDrawer,
        childScreen: Scaffold(
          backgroundColor: AppColors.white,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Text(
                    'Chưa có \nhoạt động nào',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: AppColors.startDust,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: AppColors.black,
                  ),
                  splashColor: AppColors.lightPink,
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.postingPage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _isShowDrawer ? BottomTabBar() : null,
      extendBody: true,
    );
  }
}
