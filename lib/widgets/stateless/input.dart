import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class Input extends StatelessWidget {
  final label;
  final String hintText;
  final Color textColor;
  final Color textfieldColor;
  final Function handleChange;
  final inputKey = GlobalKey<FormState>();

  Input({
    required this.label,
    required this.hintText,
    required this.textColor,
    required this.textfieldColor,
    required this.handleChange,
    required GlobalKey<FormState> inputKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: inputKey,
      child: Column(
        children: <Widget>[
          if (label != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.only(bottom: 10),
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
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: textfieldColor,
            ),
            child: TextFormField(
              onChanged: (val) => handleChange(val),
              obscureText: (hintText == 'Nhập mật khẩu') ? true : false,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              validator: (String? val) {
                return (val == null || val.isEmpty)
                    ? 'Không được bỏ trống'
                    : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
