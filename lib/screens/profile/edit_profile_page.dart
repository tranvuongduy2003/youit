import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/config/route/routes.dart';
import 'package:you_it/screens/profile/edit_description_page.dart';
import 'package:you_it/screens/profile/edit_info_page.dart';
import 'package:you_it/screens/profile/edit_link_page.dart';
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
            buildTextButton(
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => EditLinkPage(
                      githubLink: linkgh,
                      gitlabLink: linkgh,
                      linkedin: linkedin)),
                ),
              ),
            ),
          ],
        ),
        buildLinkRow('Github', linkgh.isEmpty ? 'Chưa cập nhật' : linkgh),
        buildLinkRow('Gitlab', linkgl.isEmpty ? 'Chưa cập nhật' : linkgl),
        buildLinkRow('Linkedin', linkedin.isEmpty ? 'Chưa cập nhật' : linkedin),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: Text(
          'Thông tin cá nhân',
          style: AppTextStyles.appBarText,
        ),
        handler: () => Navigator.of(context).pop(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(),
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
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                        buildTextButton(
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => EditInfoPage(
                                address: data['address'],
                                birthday: data['dob'] == null
                                    ? DateTime(1)
                                    : (data['dob'] as Timestamp).toDate(),
                                department: data['khoa'] ?? '',
                                fullName: data['userName'],
                                session: data['session'] ?? -1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildInformationRow('Tên', data['userName']),
                    buildInformationRow(
                      'Khoa',
                      data['khoa'] ?? 'Chưa cập nhật',
                    ),
                    buildInformationRow(
                        'Khoá',
                        data['session'] == null
                            ? 'Chưa cập nhật'
                            : 'K${data['session']}'),
                    buildInformationRow(
                      'Nơi ở',
                      data['address'].toString().isEmpty
                          ? 'Chưa cập nhật'
                          : data['address'],
                    ),
                    buildInformationRow(
                      'Ngày sinh',
                      data['dob'] == null
                          ? 'Chưa cập nhật'
                          : DateFormat('dd - MM - yyyy').format(
                              (data['dob'] as Timestamp).toDate(),
                            ),
                    ),
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
                        buildTextButton(
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => EditDescriptionPage(
                                  description: data['description']),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data['description'].toString().isEmpty
                            ? 'Chưa cập nhật'
                            : data['description'],
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
