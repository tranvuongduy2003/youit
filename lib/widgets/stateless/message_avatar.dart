import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class MessageAvatar extends StatelessWidget {
  final String imageUrl;

  MessageAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          child: Image.network(
            "https://picsum.photos/200",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          width: 20,
          height: 20,
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }
}
