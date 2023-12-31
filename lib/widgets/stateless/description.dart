import 'package:flutter/material.dart';

import '../../config/themes/app_text_styles.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  Widget buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: AppTextStyles.sectionTitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTitle('Mô tả'),
          Text(
            description.isEmpty ? 'Chưa cập nhật' : description,
            style: AppTextStyles.body,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
