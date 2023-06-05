import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class Input extends StatefulWidget {
  final String label;
  final String hintText;
  final Color textColor;
  final Color textfieldColor;
  final Function handleChange;
  final String exception;

  Input({
    super.key,
    this.label = '',
    required this.hintText,
    required this.textColor,
    required this.textfieldColor,
    required this.handleChange,
    this.exception = '',
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          if (widget.label != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.only(bottom: 10),
              // margin: EdgeInsets.only(right: 170),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          TextFormField(
            onChanged: (val) => widget.handleChange(val),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập đầy đủ';
              }
              if (!RegExp(widget.exception).hasMatch(value)) {
                return 'Sai cú pháp';
              }
            },
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: widget.textColor,
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
