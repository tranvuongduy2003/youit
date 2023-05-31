import 'package:flutter/material.dart';

import '../config/themes/app_text_styles.dart';

class LinkInformation extends StatelessWidget {
  final String linkGithub;
  final String linkGitlab;
  final String linkedin;
  const LinkInformation({
    super.key,
    required this.linkGithub,
    required this.linkGitlab,
    required this.linkedin,
  });

  Widget buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: AppTextStyles.sectionTitle,
      ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('Liên kết'),
        buildLinkRow('Github', linkGithub),
        buildLinkRow('Gitlab', linkGitlab),
        buildLinkRow('Linkedin', linkedin),
      ],
    );
  }
}
