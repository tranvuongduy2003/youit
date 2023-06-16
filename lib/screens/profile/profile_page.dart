import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/config/route/routes.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';

import '../../config/themes/app_text_styles.dart';
import '../../config/themes/app_colors.dart';

import '../../widgets/stateless/description.dart';
import '../../widgets/stateless/link_information.dart';

import '../../screens/profile/edit_profile_page.dart';
import '../../widgets/stateless/personal_information.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.userId});

  final String userId;

  Widget buildButton(BuildContext context, String title, bool isMe) {
    return ElevatedButton(
      onPressed: () {
        isMe
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return EditProfilePage(
                      userId: userId,
                    );
                  },
                ),
              )
            : Navigator.of(context).pushNamed(Routes.activityPage);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor:
              isMe ? AppColors.lightGray : Color(0xFF897EFF).withOpacity(0.51),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 27),
          padding: const EdgeInsets.all(0),
          alignment: Alignment.center),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int likeNumber = 200000;
    bool isMe = false;
    String likeNumberFormat = NumberFormat.decimalPattern().format(likeNumber);
    likeNumberFormat = likeNumberFormat.replaceAll(',', '.');

    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var data = futureSnapshot.data!;
          if (userId == FirebaseAuth.instance.currentUser!.uid) {
            isMe = true;
          }
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: HeaderBar(
              title: Text(
                'Thông tin cá nhân',
                style: AppTextStyles.appBarText,
              ),
              handler: () => Navigator.of(context).pop(),
              isShowIconButton: isMe ? false : true,
            ),
            body: SingleChildScrollView(
              child: Column(
                //      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        maxRadius: 40,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              data['userName'],
                              style: AppTextStyles.sectionTitle,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Số lượt thích: ',
                                style: AppTextStyles.body3,
                                children: [
                                  TextSpan(
                                    text: likeNumberFormat,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildButton(context,
                      isMe ? 'Chỉnh sửa thông tin' : 'Trò chuyện', isMe),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(),
                  PersonalInformation(
                      department: data['khoa'],
                      address: data['address'],
                      birthDay: (data['dob'] as Timestamp).toDate(),
                      session: data['session']),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(),
                  LinkInformation(
                      linkGithub: data['githubLink'],
                      linkGitlab: data['gitlabLink'],
                      linkedin: data['linkedin']),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(),
                  Description(description: data['description']),
                ],
              ),
            ),
          );
        });
  }
}
