import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';

class GroupInformationPage extends StatefulWidget {
  const GroupInformationPage({super.key});

  @override
  State<GroupInformationPage> createState() => _GroupInformationPageState();
}

class _GroupInformationPageState extends State<GroupInformationPage> {
  Future<void> openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(),
            height: 319,
            width: 321,
          ),
        );
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nhóm UIT'),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
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
                            Icon(color: Colors.black, Icons.person_2_outlined),
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
                      onPressed: () {}),
                  CircleButton(
                      imageAsset: 'assets/images/add_member.png',
                      buttonColor: AppColors.isabelline,
                      onPressed: () {})
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.isabelline,
                      minimumSize: Size(350, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () => openDialog(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Nhóm UIT',
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.isabelline,
                      minimumSize: Size(350, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () => {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 275,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Nhóm này là dành cho môn học yêu cầu ',
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.isabelline,
                      minimumSize: Size(350, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () => {},
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
                      onPressed: () {})),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            )
          ],
        ),
      ),
    );
  }
}
