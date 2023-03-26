import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/config/route/routes.dart';

import '../../config/themes/app_text_styles.dart';
import '../../config/themes/app_colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  Widget buildTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.sectionTitle,
    );
  }

  Widget buildRowInformation(
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
    int likeNumber = 200000;
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: AppTextStyles.sectionTitle,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.lineColor,
            height: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                  buildTextButton(() =>
                      Navigator.of(context).pushNamed(Routes.editInfoPage)),
                ],
              ),
              buildInformationRow('Tên', name),
              buildInformationRow('Khoa', department),
              buildInformationRow('Khoá', 'K$seesion'),
              buildInformationRow('Nơi ở', address),
              buildInformationRow(
                  'Ngày sinh', DateFormat('dd - MM - yyyy').format(birthDay)),
              const SizedBox(height: 3),
              const Divider(),
              buildRowInformation(context, linkGitHub, linkGitLab, linkedin),
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
              const Text(
                description,
                style: AppTextStyles.body3,
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
