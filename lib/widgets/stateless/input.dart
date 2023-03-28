import 'package:flutter/material.dart';
import 'package:you_it/config/responsive.dart';
import 'package:you_it/config/themes/app_colors.dart';

class Input extends StatelessWidget {
  final String label;
  final String hintText;
  final Color textColor;
  final Color textfieldColor;
  final Function handleChange;

  Input({
    required this.label,
    required this.hintText,
    required this.textColor,
    required this.textfieldColor,
    required this.handleChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15),
            // margin: EdgeInsets.only(right: 170),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: textfieldColor,
            ),
            child: TextField(
              onChanged: (val) => handleChange(val),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
