import 'package:flutter/material.dart';

class UserInbox extends StatelessWidget {
  const UserInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
        ],
      ),
    );
  }
}
