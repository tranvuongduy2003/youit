import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../widgets/stateless/circle_button.dart';
import '../../widgets/stateless/header_bar.dart';
import '../../widgets/stateless/more_info_member_modal.dart';
import '../../widgets/stateless/delete_member_modal_button.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  String avtURL =
      'https://media.istockphoto.com/id/1387522045/vi/anh/m%C3%A8o-x%C3%A1m-l%E1%BB%9Bn-v%C3%A0-nghi%C3%AAm-t%C3%BAc.jpg?s=612x612&w=0&k=20&c=xoWOttW9yoWSWk-ju-CwdDeygkyrCVClytGobWE4aZA=';
  String name = 'Nhat Zi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
          title: Text(
            'Thành viên',
            style: AppTextStyles.appBarText,
          ),
          handler: Navigator.of(context).pop),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                height: 65,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Color(0xffF4F087),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(avtURL),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: AppTextStyles.unSeenMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleButton(
                            buttonColor: AppColors.pinkRed,
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return DeleteMemberModal();
                                  });
                            },
                            size: 40,
                            isImageButton: false,
                            icon: Icon(Icons.close),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleButton(
                            buttonColor: Color(0xff92A8F6),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return MoreInfoModal(
                                      avtURL: avtURL,
                                      name: name,
                                    );
                                  });
                            },
                            size: 40,
                            isImageButton: false,
                            icon: Icon(Icons.more_vert),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: 9,
        ),
      ),
    );
  }
}
