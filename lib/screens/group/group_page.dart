import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:you_it/widgets/stateful/createGroup.dart';
import 'package:you_it/widgets/stateful/groupListButton.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  set result(String result) {}
  createGroup() {}

  @override
  Widget build(BuildContext context) {
    Future createGroup() => showDialog(
          context: context,
          builder: (BuildContext context) {
            return CreateGroup();
          },
        );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: AppColors.lightGreen),
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                width: double.infinity,
                color: AppColors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 270,
                      margin: EdgeInsets.only(left: 20, right: 10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: AppColors.grey.withOpacity(1),
                      ),
                      child: TextField(
                        onChanged: null,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black,
                          ),
                          hintText: 'Tìm kiếm...',
                          hintStyle: AppTextStyles.body,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: ElevatedButton(
                        onPressed: () => {createGroup()},
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.lightBlue.withOpacity(1),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45),
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GroupListButton(),
            ],
          ),
        ),
      ),
    );
  }
}
