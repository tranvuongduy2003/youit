import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final bool isJoinGroup;
  Function(bool?)? onChanged;

  GroupCard({
    super.key,
    required this.groupName,
    required this.isJoinGroup,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isJoinGroup = isJoinGroup;

    onChanged() {
      _isJoinGroup = !_isJoinGroup;
      return _isJoinGroup;
    }

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
                Flexible(
                  child: Container(
                    width: 150,
                    child: Text(
                      groupName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.groupBlack.withOpacity(1),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
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
          Container(
            width: 100,
            height: 36,
            //margin: EdgeInsets.only(right:),
            child: ElevatedButton(
              onPressed: () => onChanged(),
              child: Text('Truy cập'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppColors.lightBlue.withOpacity(1),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(37),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
