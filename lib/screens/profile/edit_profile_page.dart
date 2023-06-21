import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:you_it/screens/profile/edit_description_page.dart';
import 'package:you_it/screens/profile/edit_info_page.dart';
import 'package:you_it/screens/profile/edit_link_page.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

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

  handleTakePhoto() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage == null) {
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${pickedImage.name}');

      print(pickedImage.path);
      await storageRef.putFile(File(pickedImage.path));
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'avatar': imageUrl,
      });
    } catch (e) {
      print(e);
    }
  }

  handleUploadPhoto() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage == null) {
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${pickedImage.name}');

      await storageRef.putFile(File(pickedImage.path));
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'avatar': imageUrl,
      });
    } catch (e) {
      print(e);
    }
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
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          data['avatar'] ?? '',
                        ),
                        backgroundColor: Colors.black12,
                        radius: 40,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text('Take a photo'),
                                onTap: handleTakePhoto,
                              ),
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text('Choose a photo'),
                                onTap: handleUploadPhoto,
                              ),
                            ],
                          );
                        },
                      ),
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
