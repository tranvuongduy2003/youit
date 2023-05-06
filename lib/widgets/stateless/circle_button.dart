import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {super.key,
      required this.imageAsset,
      required this.buttonColor,
      required this.onPressed,
      required this.size});
  final String imageAsset;
  final Color buttonColor;
  final Function() onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      elevation: 2,
      child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Ink(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(50)),
            child: Image.asset(imageAsset),
          )),
    );
  }
}
