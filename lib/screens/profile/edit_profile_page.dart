import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/config/route/routes.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';

import '../../config/themes/app_text_styles.dart';
import '../../config/themes/app_colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    Key? key,
    required this.userId,
  });

  final String userId;

  Widget buildTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.sectionTitle,
    );
  }

  Widget buildLinkInformationRow(
    BuildContext context,
    String linkgh,
    String linkgl,
    String linkedin,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTitle('Liên kết'),
            buildTextButton(() => Navigator.of(context).pushNamed(
                  Routes.editLinkPage,
                )),
          ],
        ),
        buildLinkRow('Github', linkgh),
        buildLinkRow('Gitlab', linkgl),
        buildLinkRow('Linkedin', linkedin),
      ],
    );
  }

  Widget buildLinkRow(String title, String link) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.heading,
          ),
          Text(
            link.length > 20 ? '${link.substring(0, 20)} ...' : link,
            style: AppTextStyles.body3,
          ),
        ],
      ),
    );
  }

  Widget buildTextButton(Function natigator) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => natigator(),
      child: Row(
        children: const [
          Text(
            'Chỉnh sửa',
            style: AppTextStyles.heading,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget buildInformationRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.heading,
          ),
          Text(
            detail,
            style: AppTextStyles.body3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const name = 'Nguyễn Hoàng Anh';
    const department = 'Công nghệ phần mềm';
    const seesion = 16;
    const address = 'Bình Dương';
    DateTime birthDay = DateTime(2003, 8, 18);
    const linkGitHub = 'github.com/nguyenhoanganh1808';
    const linkGitLab = 'gitlab.com/21521830';
    const linkedin = 'linkedin.com/in/nguyenhoanganh';
    const description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: Text(
          'Thông tin cá nhân',
          style: AppTextStyles.appBarText,
        ),
        handler: () => Navigator.of(context).pop(),
      ),
      body: FutureBuilder(
          future:
              FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var data = futureSnapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/564x/95/28/c9/9528c96c953ef26053bfa83b0eda9fdb.jpg',
                        ),
                        radius: 40,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.5, 27),
                        backgroundColor: AppColors.lightperiwinkle,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'Đổi ảnh đại diện',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    //const SizedBox(height: 0),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTitle('Thông tin cá nhân'),
                        buildTextButton(() => Navigator.of(context)
                            .pushNamed(Routes.editInfoPage)),
                      ],
                    ),
                    buildInformationRow('Tên', data['userName']),
                    buildInformationRow('Khoa', data['khoa']),
                    buildInformationRow(
                        'Khoá',
                        data['session'] == -1
                            ? 'Chưa cập nhật'
                            : 'K${data['session']}'),
                    buildInformationRow('Nơi ở', data['address']),
                    buildInformationRow(
                        'Ngày sinh',
                        DateFormat('dd - MM - yyyy')
                            .format((data['dob'] as Timestamp).toDate())),
                    const SizedBox(height: 3),
                    const Divider(),
                    buildLinkInformationRow(context, data['githubLink'],
                        data['gitlabLink'], data['linkedin']),
                    const SizedBox(height: 3),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTitle('Mô tả'),
                        buildTextButton(() => Navigator.of(context)
                            .pushNamed(Routes.editDescriptionPage)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data['description'],
                        style: AppTextStyles.body3,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
