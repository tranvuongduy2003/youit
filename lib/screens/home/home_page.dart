import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isClicked = false;

  void changeHeart() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  Widget buildTextButton(Function natigator) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => natigator(),
      child: Row(
        children: const [
          Text(
            'Chỉnh sửa',
            style: AppTextStyles.heading,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {});
                    },
                    child: Ink(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset('assets/images/chat_bubble_1.png'),
                    ),
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
          ),
          Stack(
            children: [
              Positioned(
                top: 20,
                right: 20,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {});
                    },
                    child: Ink(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset('assets/images/settings_1.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}
