import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../service/database_service.dart';
import 'circle_button.dart';

class PostForm extends StatefulWidget {
  const PostForm(
      {super.key,
      required this.groupId,
      required this.contentController,
      required this.topicController});

  final String groupId;
  final TextEditingController topicController;
  final TextEditingController contentController;

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            'Chủ đề',
            style: AppTextStyles.mont20,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: widget.topicController,
            style: AppTextStyles.postingInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.black.withOpacity(0.11),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                focusColor: AppColors.black.withOpacity(0.11)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            'Nội dung',
            style: AppTextStyles.mont20,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: widget.contentController,
            style: AppTextStyles.postingInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.black.withOpacity(0.11),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                focusColor: AppColors.black.withOpacity(0.11)),
            maxLines: 11,
            onSubmitted: (value) {},
          ),
        ),
      ],
    );
  }
}
