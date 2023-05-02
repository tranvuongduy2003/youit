import 'package:flutter/material.dart';
import 'dart:math';

class NewMessage extends StatelessWidget {
  const NewMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Transform.rotate(
              angle: 45 * pi / 180,
              child: IconButton(
                icon: Icon(
                  Icons.attach_file_sharp,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nhắn tin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFE6E6E6),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
