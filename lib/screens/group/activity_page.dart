import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/drawer_and_bottom_nav.dart';
import '../bottom_bar/bottom_nav_bar_page.dart';
import '../../widgets/stateless/post_form.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool _isShowDrawer = false;
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

  @override
  Widget build(BuildContext context) {
    const groupName = 'Nhóm UIT';
    int hoatdong = 1; // dung de test

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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: hoatdong != 0
              ? CircleButton(
                  buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.postingPage);
                  },
                  isImageButton: false,
                  icon: Icon(Icons.add),
                )
              : null,
          backgroundColor: AppColors.white,
          body: hoatdong == 0
              ? Container(
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
                      CircleButton(
                        buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.postingPage);
                        },
                        isImageButton: false,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              margin: EdgeInsets.only(top: 5),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Được đăng bởi:   ',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: AppColors.startDust,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Bình Đần',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return _BuildDialog();
                                    });
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: AppColors.jordyBlue.withOpacity(0.36),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Thi cuối kì',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 124,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 25,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Color(0xFFFFD3D3).withOpacity(0.56),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              child: Text(
                                'T6 tuần này chúng ta sẽ có bài kt nhỏ: Nội dung gồm: \nA \nB \nC',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9A1313),
                                ),
                              ),
                            ),
                          ],
                        ),
                        itemCount: hoatdong,
                      ),
                    ),
                  ],
                ),
        ),
      ),

      // bottomNavigationBar: _isShowDrawer ? BottomTabBar(0, (i) {}) : null,
      extendBody: true,
    );
  }
}

class _BuildDialog extends StatelessWidget {
  const _BuildDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56),
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            PostForm(),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CircleButton(
                        buttonColor: Color(0xFFF41B1B).withOpacity(0.36),
                        onPressed: () {},
                        isImageButton: false,
                        icon: Icon(
                          Icons.close,
                          color: Color(0xFFF41B1B),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        //width: 119,
                        child: Text(
                          'Xóa bài viết',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF0000),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CircleButton(
                        buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                        onPressed: () {},
                        imageAsset: 'assets/images/cancel.png',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        // width: 119,

                        child: Text(
                          'Huỷ',
                          style: AppTextStyles.mont20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
