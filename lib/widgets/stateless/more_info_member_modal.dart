import 'package:flutter/material.dart';

import '../../config/themes/app_text_styles.dart';
import '../../screens/message/message_detail_page.dart';
import '../../screens/profile/profile_page.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/text_circle_button.dart';

class MoreInfoModal extends StatelessWidget {
  const MoreInfoModal({super.key, required this.avtURL, required this.name});
  final String avtURL;
  final String name;
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(avtURL),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: AppTextStyles.appBarText,
                    ),
                  )
                ],
              ),
            ),
            TextCircleButton(
              btn: CircleButton(
                  imageAsset: 'assets/images/profile.png',
                  buttonColor: Color(0xffFCFF7B),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                  size: 60),
              txt: 'Xem thông tin',
            ),
            TextCircleButton(
              btn: CircleButton(
                  isImageButton: false,
                  icon: Icon(
                    Icons.chat_outlined,
                    size: 33,
                  ),
                  buttonColor: Color(0xff92F696),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MessageDetailPage()));
                  },
                  size: 60),
              txt: 'Trò chuyện',
            )
          ],
        ),
      ),
    );
  }
}
