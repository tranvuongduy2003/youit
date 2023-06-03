import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class Input extends StatelessWidget {
  final label;
  final String hintText;
  final Color textColor;
  final Color textfieldColor;
  final Function handleChange;
  final String exception;

  Input(
      {required this.label,
      required this.hintText,
      required this.textColor,
      required this.textfieldColor,
      required this.handleChange,
      required this.exception});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          TextFormField(
            onChanged: (val) => handleChange(val),
            validator: (value) {
              if (value!.isEmpty) {
                return "Vui lòng nhập đầy đủ";
              }
              if (!RegExp(exception).hasMatch(value)) {
                return "Sai cú pháp";
              }
            },
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(45)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(45),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(45),
                )),
          ),
        ],
      ),
    );
  }
}
