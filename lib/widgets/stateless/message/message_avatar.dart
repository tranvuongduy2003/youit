import 'package:flutter/material.dart';

class MessageAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;

  MessageAvatar({required this.imageUrl, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        imageUrl != null && imageUrl != ''
            ? CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.black12,
              )
            : CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black12,
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
