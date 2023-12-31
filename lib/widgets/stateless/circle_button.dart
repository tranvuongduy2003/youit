import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.imageAsset = '',
    required this.buttonColor,
    required this.onPressed,
    this.isImageButton = true,
    this.icon = const Icon(Icons.add),
    this.size = 55,
  });
  final String imageAsset;
  final Color buttonColor;
  final VoidCallback? onPressed;
  final bool isImageButton;
  final Icon icon;
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
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: isImageButton
              ? Image.asset(
                  imageAsset,
                  color: Colors.black,
                )
              : icon,
        ),
      ),
    );
  }
}
