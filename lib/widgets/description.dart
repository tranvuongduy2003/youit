import 'package:flutter/material.dart';

import '../config/themes/app_text_styles.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  Widget buildTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: AppTextStyles.sectionTitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTitle('Mô tả'),
        Container(
          margin: const EdgeInsets.symmetric(),
          child: Text(
            description,
            style: AppTextStyles.body,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
