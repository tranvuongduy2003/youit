import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';

class DeleteMemberModal extends StatelessWidget {
  const DeleteMemberModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          )),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Bạn muốn xóa thành viên này ra khỏi nhóm?',
              maxLines: 2,
              style: AppTextStyles.modalTitle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                child: Column(
                  children: [
                    CircleButton(
                        imageAsset: 'assets/images/out_group.png',
                        buttonColor: AppColors.pinkRed,
                        onPressed: () {},
                        size: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Xóa',
                        style: AppTextStyles.modalTitle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  CircleButton(
                      imageAsset: 'assets/images/cancel.png',
                      buttonColor: Color(0xff92A8F6),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      size: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Hủy',
                      style: AppTextStyles.modalTitle,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
