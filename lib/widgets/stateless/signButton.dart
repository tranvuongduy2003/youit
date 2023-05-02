import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class SignButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final Color backgroundColor;

  SignButton({
    required this.buttonText,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
