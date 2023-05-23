import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

import '../../config/route/routes.dart';
import '../../config/themes/app_colors.dart';
import '../bottom_bar/bottom_nav_bar_page.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/drawer_and_bottom_nav.dart';

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({super.key});

  @override
  State<UploadFilePage> createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  bool _isShowDrawer = false;
  bool _showDowload = false;
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

  void _showDownloadContainer() {
    setState(() {
      _showDowload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const groupName = 'Nhóm UIT';
    int slfile = 2; //test

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
      // bottomNavigationBar: _isShowDrawer ? BottomTabBar(0, (i) {}//) : null,
      extendBody: true,
      body: DrawerAndBottomNav(
        keyDrawer: keyDrawer,
        groupName: groupName,
        isShowDrawer: _isShowDrawer,
        openDrawer: _openDrawer,
        closeDrawer: _closeDrawer,
        childScreen: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _showDowload
              ? null
              : CircleButton(
                  buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                  onPressed: () {},
                  imageAsset: 'assets/images/upload.png',
                  size: 55,
                ),
          backgroundColor: AppColors.white,
          body: slfile == 0
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
                          'Chưa có tệp tin nào \nđược tải lên',
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
                        imageAsset: 'assets/images/upload.png',
                        size: 55,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 42),
                          child: Text(
                            'Tệp tin',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 90),
                          child: Text(
                            'Người tải',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: slfile,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Color(0xFFF4F087).withOpacity(0.36),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 22),
                                      child: Text(
                                        'abcdxyz.doc',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 0),
                                      width: 100,
                                      child: Text(
                                        'Nguyễn Hoàng Anh',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _showDownloadContainer,
                                      icon: Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    if (_showDowload)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(111),
                            topRight: Radius.circular(111),
                          ),
                          color: Color(0xFFFFFCFC),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Tải tệp tin về máy',
                                      style: AppTextStyles.mont20),
                                  CircleButton(
                                    buttonColor: Color(0xFFFCFF7B),
                                    onPressed: () {},
                                    icon: Icon(Icons.file_download_outlined),
                                    isImageButton: false,
                                    size: 55,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 182,
                                    child: Text('Xóa tệp',
                                        style: AppTextStyles.mont20),
                                  ),
                                  CircleButton(
                                    buttonColor:
                                        Color(0xFFFF9AA2).withOpacity(0.36),
                                    onPressed: () {},
                                    isImageButton: false,
                                    icon: Icon(
                                      Icons.close,
                                      color: Color(0xFFF41B1B),
                                    ),
                                    size: 55,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
