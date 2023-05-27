import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  const GroupCard({
    super.key,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        bottom: 5,
      ),
      width: 350,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: AppColors.blueText.withOpacity(1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    groupName,
                    style: TextStyle(
                      color: AppColors.groupBlack.withOpacity(1),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    '10 thanh vien',
                    style: TextStyle(
                      color: AppColors.groupBlack.withOpacity(1),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
