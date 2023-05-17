import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.lightGreen),
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.purple,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 270,
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.only(
                      top: 4,
                      bottom: 9,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.amber,
                    ),
                    child: TextField(
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Searching...',
                        hintStyle: AppTextStyles.body,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
