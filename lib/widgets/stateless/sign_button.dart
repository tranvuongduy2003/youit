import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback handleOnPress;

  SignButton({
    required this.buttonText,
    required this.textColor,
    required this.backgroundColor,
    required this.handleOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
        onPressed: handleOnPress,
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
