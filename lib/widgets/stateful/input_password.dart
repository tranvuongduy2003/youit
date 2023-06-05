import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../config/themes/app_colors.dart';

class InputPassword extends StatefulWidget {
  final label;
  final String hintText;
  final Color textColor;
  final Color textfieldColor;
  final Function handleChange;
  final String exception;
  bool passToggle = true;
  bool isConfirmed;
  InputPassword({
    super.key,
    required this.label,
    required this.hintText,
    required this.textColor,
    required this.textfieldColor,
    required this.handleChange,
    required this.exception,
    this.isConfirmed = true,
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
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
                  return 'Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, chữ số và ký tự đặc biệt (!,#,%,&,@)';
                }
                if (widget.isConfirmed == false) {
                  return 'Mật khẩu nhập lại không chính xác';
                }
              },
              obscureText: widget.passToggle,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        widget.passToggle = !widget.passToggle;
                      });
                    },
                    child: Icon(widget.passToggle
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
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
                      borderSide:
                          const BorderSide(width: 0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(45)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(45),
                  ))),
        ],
      ),
    );
    ;
  }
}
