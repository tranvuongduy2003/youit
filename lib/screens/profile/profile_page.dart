import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/widgets/stateless/header_bar.dart';

import '../../config/themes/app_text_styles.dart';
import '../../config/themes/app_colors.dart';

import '../../widgets/description.dart';
import '../../widgets/link_information.dart';

import '../../screens/profile/edit_profile_page.dart';
import '../../widgets/personal_information.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget buildButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return const EditProfilePage();
            },
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 27),
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
    const name = 'Nguyễn Hoàng Anh';
    int likeNumber = 200000;
    const department = 'Công nghệ phần mềm';
    int seesion = 16;
    const address = 'Bình Dương';
    DateTime birthDay = DateTime(2003, 8, 18);
    const linkGithub = 'github.com/nguyenhoanganh1808';
    const linkGitlab = 'gitlab.com/21521830';
    const linkedin = 'linkedin.com/in/nguyenhoanganh';
    const description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.';

    String likeNumberFormat = NumberFormat.decimalPattern().format(likeNumber);
    likeNumberFormat = likeNumberFormat.replaceAll(',', '.');

    final AppBarTheme appBarTheme = AppBarTheme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   centerTitle: appBarTheme.centerTitle,
      //   elevation: appBarTheme.elevation,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new),
      //     color: Colors.black,
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     'Thông tin cá nhân',
      //     style: appBarTheme.titleTextStyle,
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(1.0),
      //     child: Container(
      //       color: AppColors.lineColor,
      //       height: 1.0,
      //     ),
      //   ),
      //   //backgroundColor: appBarTheme.backgroundColor,
      // ),
      appBar: HeaderBar(
        appBar: AppBar(),
        title: 'Thông tin cá nhân',
        handler: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: AppColors.primaryColor,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        name,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            buildButton(context, 'Chỉnh sửa thông tin'),
            const SizedBox(
              height: 3,
            ),
            const Divider(),
            PersonalInformation(
                department: department,
                address: address,
                birthDay: birthDay,
                seesion: seesion),
            const SizedBox(
              height: 3,
            ),
            const Divider(),
            const LinkInformation(
                linkGithub: linkGithub,
                linkGitlab: linkGitlab,
                linkedin: linkedin),
            const SizedBox(
              height: 3,
            ),
            const Divider(),
            const Description(description: description),
          ],
        ),
      ),
    );
  }
}
