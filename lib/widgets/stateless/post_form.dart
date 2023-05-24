import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class PostForm extends StatelessWidget {
  const PostForm({super.key});

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
