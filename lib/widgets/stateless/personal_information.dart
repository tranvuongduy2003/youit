import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_text_styles.dart';

class PersonalInformation extends StatelessWidget {
  final String department;
  final int session;
  final String address;
  final DateTime birthDay;
  const PersonalInformation({
    super.key,
    required this.department,
    required this.address,
    required this.birthDay,
    required this.session,
  });

  Widget buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        title,
        style: AppTextStyles.sectionTitle,
      ),
    );
  }

  Widget buildRowIconText(IconData icon, Text title) {
    return Row(children: [
      Icon(
        icon,
        color: Colors.black,
      ),
      const SizedBox(
        width: 10,
      ),
      title,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('Thông tin cá nhân'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowIconText(
                  Icons.anchor,
                  Text(
                    department,
                    style: AppTextStyles.heading,
                  )),
              buildRowIconText(
                  Icons.school,
                  Text(
                    'K $session',
                    style: AppTextStyles.heading,
                  )),
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Đến từ ',
                      style: AppTextStyles.heading,
                      children: [
                        TextSpan(
                            text: address,
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ],
              ),
              buildRowIconText(
                Icons.cake,
                Text(
                  DateFormat('dd - MM - yyyy').format(DateTime(2003)),
                  style: AppTextStyles.heading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
