import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class Input extends StatelessWidget {
  final String label;
  final String hintText;
  final Color textColor;
  final Color textfieldColor;

  Input(
    @required this.label,
    @required this.hintText,
    @required this.textColor,
    @required this.textfieldColor,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 170),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.fontColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 55,
            width: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: textfieldColor,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: textColor,
                  fontSize: 15,
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
