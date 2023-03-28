import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: AssetImage('assets/images/home_background.png'),
          fit: BoxFit.cover,
        ),
        Stack(
          children: [
            Positioned(
              top: 20,
              right: 80,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset('assets/images/chat_bubble_1.png'),
                ),
              ),
            ),
            Positioned(
                top: 55,
                right: 80,
                child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: Color(0xffffE9E9E9),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "9",
                      style: TextStyle(
                          fontSize: 11.7,
                          height: 1.3,
                          color: Color(0xfffEF6565)),
                      textAlign: TextAlign.center,
                    ))),
          ],
        )
      ],
    );
  }
}
