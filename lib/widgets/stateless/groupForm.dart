import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class GroupForm extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onCreate;
  final VoidCallback onCancel;
  const GroupForm({
    Key? key,
    required this.controller,
    required this.onCreate,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        top: 150,
        bottom: 150,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(56),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 15,
            ),
            child: Text(
              'Tên nhóm',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.black.withOpacity(1),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              enterName(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  createButton(),
                  cancelButton(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget enterName() => Container(
        margin: EdgeInsets.only(top: 10),
        width: 370,
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.black.withOpacity(0.11),
            width: 0.5,
          ),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: AppColors.black.withOpacity(0.5),
              fontSize: 19,
            ),
            hintText: 'Nhập tên nhóm...',
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: AppColors.black.withOpacity(1),
            fontSize: 19,
          ),
        ),
      );

  Widget createButton() => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 45,
              width: 45,
              child: ElevatedButton(
                onPressed: onCreate,
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.yellow.withOpacity(0.8),
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
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 15,
              ),
              child: Text(
                'Tạo nhóm',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      );

  Widget cancelButton() => Container(
        margin: EdgeInsets.only(top: 30, right: 20),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 45,
              width: 45,
              child: ElevatedButton(
                onPressed: onCancel,
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.lightBlue.withOpacity(0.8),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                child: Icon(
                  Icons.signal_cellular_nodata_rounded,
                  color: Colors.pink,
                  size: 16,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 15,
              ),
              child: Text(
                'Hủy',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      );
}
