import 'package:flutter/material.dart';
import 'package:you_it/config/route/routes.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../service/database_service.dart';
import '../../widgets/stateless/circle_button.dart';

class DeleteMemberModal extends StatefulWidget {
  const DeleteMemberModal(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userDeleteId,
      required this.userDeleteName});

  final String userDeleteId;
  final String userDeleteName;
  final String groupId;
  final String groupName;

  @override
  State<DeleteMemberModal> createState() => _DeleteMemberModalState();
}

class _DeleteMemberModalState extends State<DeleteMemberModal> {
  bool _isLoading = false;
  Future deleteMember(String userIdDelete, String userNameDelete,
      String groupId, String groupName) async {
    setState(() {
      _isLoading = true;
    });
    await DatabaseService(uid: userIdDelete)
        .outGroup(userNameDelete, groupId, groupName)
        .then((value) => Navigator.of(context)
            .pushReplacementNamed(Routes.bottomNavBarWithGroupListPage));
    setState(() {
      _isLoading = false;
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CircleButton(
                            imageAsset: 'assets/images/out_group.png',
                            buttonColor: AppColors.pinkRed,
                            onPressed: () {
                              deleteMember(
                                  widget.userDeleteId,
                                  widget.userDeleteName,
                                  widget.groupId,
                                  widget.groupName);
                            },
                            size: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Xóa thành viên',
                        style: AppTextStyles.modalTitle,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
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
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
