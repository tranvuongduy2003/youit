import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../screens/group/member_list_page.dart';
import '../../widgets/stateless/circle_button.dart';

class GroupInformationPage extends StatefulWidget {
  const GroupInformationPage({super.key});

  @override
  State<GroupInformationPage> createState() => _GroupInformationPageState();
}

class _GroupInformationPageState extends State<GroupInformationPage> {
  String groupName = 'Nhóm UIT';
  String groupDescription = 'Nhóm này là dành cho môn học yêu cầu ';

  Future<void> openDialog(BuildContext context, String title, String content) =>
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(),
                width: 340,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        title,
                        style: AppTextStyles.appBarText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        initialValue: content,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleButton(
                                  imageAsset: 'assets/images/save.png',
                                  buttonColor: Color(0xffFCFF7B),
                                  onPressed: () {},
                                  size: 55),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Lưu',
                                  style: AppTextStyles.appBarText,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleButton(
                                  imageAsset: 'assets/images/cancel.png',
                                  buttonColor: Color(0xff92A8F6),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  size: 55),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Hủy',
                                  style: AppTextStyles.appBarText,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.lightPink,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nhóm UIT', style: AppTextStyles.groupName),
                          Row(
                            children: [
                              Icon(
                                  color: Colors.black, Icons.person_2_outlined),
                              Text(
                                'Có 10 thành viên',
                                style: AppTextStyles.heading,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleButton(
                        imageAsset: 'assets/images/announcement_bell.png',
                        buttonColor: AppColors.isabelline,
                        onPressed: () {},
                        size: 55),
                    CircleButton(
                        imageAsset: 'assets/images/add_member.png',
                        buttonColor: AppColors.isabelline,
                        onPressed: () {},
                        size: 55)
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 40),
                  child: Text(
                    'Tên nhóm',
                    style: AppTextStyles.appBarText,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.isabelline,
                        minimumSize: Size(350, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () =>
                          openDialog(context, 'Tên nhóm', groupName),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              groupName,
                              style: AppTextStyles.body,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/images/edit.png'),
                          )
                        ],
                      ),
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10, left: 40),
                  child: Text(
                    'Mô tả',
                    style: AppTextStyles.appBarText,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.isabelline,
                        minimumSize: Size(350, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () =>
                          openDialog(context, 'Mô tả', groupDescription),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 275,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              groupDescription,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/images/edit.png'),
                          )
                        ],
                      ),
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10, left: 40),
                  child: Text(
                    'Thành viên',
                    style: AppTextStyles.appBarText,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.isabelline,
                        minimumSize: Size(350, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MemberListPage())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              color: Colors.black,
                              Icons.person_2_outlined,
                              size: 30,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Thành viên (10)',
                              style: AppTextStyles.sectionTitle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                                color: Colors.black, Icons.arrow_forward_ios),
                          )
                        ],
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: CircleButton(
                        imageAsset: 'assets/images/out_group.png',
                        buttonColor: Color(0xffFF9AA2),
                        onPressed: () {},
                        size: 55)),
              ],
            ),
          ),
        ),
      ),

      //bottomNavigationBar: _isShowDrawer ? BottomTabBar() : null,
      extendBody: true,
    );
  }
}
