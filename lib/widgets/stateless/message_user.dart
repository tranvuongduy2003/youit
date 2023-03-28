import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/message_avatar.dart';

class MessageUser extends StatelessWidget {
  const MessageUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      width: double.infinity,
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MessageAvatar(
              imageUrl: 'https://picsum.photos/50',
            ),
            Container(
              height: 70,
              width: constraints.maxWidth - 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Nhật Vy',
                        style: AppTextStyles.unSeenMessageTitle,
                      ),
                      Text(
                        'Chơi khong học...',
                        style: AppTextStyles.unSeenMessage,
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
