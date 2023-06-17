import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class MessageAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;

  MessageAvatar({required this.imageUrl, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage("https://picsum.photos/200"),
        ),
        Positioned(
          width: 20,
          height: 20,
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }
}
