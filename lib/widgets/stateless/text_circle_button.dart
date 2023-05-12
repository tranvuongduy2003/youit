import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';

import '../../config/themes/app_text_styles.dart';

class TextCircleButton extends StatelessWidget {
  const TextCircleButton({super.key, this.txt = '', required this.btn});

  @override
  final String txt;
  final CircleButton btn;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: AppTextStyles.modalTitle,
          ),
          btn
        ],
      ),
    );
  }
}
