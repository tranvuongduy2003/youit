import 'dart:math';

import 'package:flutter/material.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';
import 'package:you_it/widgets/stateless/post_form.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../widgets/stateless/header_bar.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        appBar: AppBar(),
        title: Text(
          'Đăng bài viết',
          style: AppTextStyles.appBarText,
        ),
        handler: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostForm(),
          Spacer(),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(111),
                topRight: Radius.circular(111),
              ),
              //color: //Color(0xFFFFFCFC),
              color: Color(0xFFFFFCFC),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      // ElevatedButton(
                      //   child: Icon(
                      //     Icons.file_upload_outlined,
                      //     color: AppColors.black,
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0xFFFCFF7B).withOpacity(0.39),
                      //     shape: CircleBorder(),
                      //     padding: EdgeInsets.all(20),
                      //     elevation: 0,
                      //   ),
                      //   onPressed: () {},
                      // ),
                      CircleButton(
                        buttonColor: Color(0xFFFCFF7B).withOpacity(0.39),
                        onPressed: () {},
                        imageAsset: ('assets/images/upload.png'),
                      ),
                      SizedBox(height: 5),
                      Text('Đăng bài', style: AppTextStyles.mont20),
                    ],
                  ),
                  Column(
                    children: [
                      // ElevatedButton(
                      //   child: Transform.rotate(
                      //     angle: 180 * pi / 180,
                      //     child: Icon(
                      //       Icons.subdirectory_arrow_right_outlined,
                      //       color: AppColors.black,
                      //     ),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor:
                      //         AppColors.jordyBlue.withOpacity(0.36),
                      //     shape: CircleBorder(),
                      //     padding: EdgeInsets.all(20),
                      //     elevation: 0,
                      //   ),
                      //   onPressed: () {},
                      // ),
                      CircleButton(
                        buttonColor: AppColors.jordyBlue.withOpacity(0.36),
                        onPressed: () {},
                        imageAsset: 'assets/images/cancel.png',
                      ),
                      SizedBox(height: 5),
                      Text('Huỷ', style: AppTextStyles.mont20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
