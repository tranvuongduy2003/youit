import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/service/database_service.dart';
import 'package:you_it/widgets/stateless/circle_button.dart';
import 'package:you_it/widgets/stateless/show_snackbar.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  final String userId;
  final String userName;

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final controller = TextEditingController();
  bool _isLoading = false;

  Future _createNewGroup(
      String userId, String userName, String groupName) async {
    String value = controller.text;

    if (value != '') {
      try {
        setState(() {
          _isLoading = true;
        });
        final CollectionReference groupsCollection =
            FirebaseFirestore.instance.collection('groups');
        final CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
        // DatabaseService(uid: user!.uid)
        //     .createGroup(userName, user!.uid, value)
        //     .then((val) {
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // });
        DocumentReference groupDocumentReference = await groupsCollection.add({
          'groupName': groupName,
          'groupIcon': '',
          'admin': '${userId}_$userName',
          'members': [],
          'groupId': '',
          'description': '',
          'createAt': DateTime.now(),
          'recentMessage': '',
          'recentMessageSender': '',
        });

        await groupDocumentReference.update({
          'members': FieldValue.arrayUnion(['${userId}_$userName']),
          'groupId': groupDocumentReference.id,
        });

        DocumentReference userDocumentReference = usersCollection.doc(userId);
        await userDocumentReference.update({
          'groups':
              FieldValue.arrayUnion(['${groupDocumentReference.id}_$groupName'])
        });
        if (context.mounted) {
          ShowSnackbar()
              .showSnackBar(context, Colors.green, 'Tạo group thành công');
        }
        setState(() {
          _isLoading = false;
        });
      } on FirebaseException catch (e) {
        ShowSnackbar().showSnackBar(context, Colors.red, e);
        setState(() {
          _isLoading = false;
        });
      } on PlatformException catch (e) {
        ShowSnackbar().showSnackBar(context, Colors.red, e);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        ShowSnackbar().showSnackBar(context, Colors.red, e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(56),
      ),
      actions: [
        Column(
          children: <Widget>[
            _isLoading
                ? CircularProgressIndicator()
                : CircleButton(
                    buttonColor: AppColors.yellow.withOpacity(0.8),
                    onPressed: () {
                      // _createNewGroup(widget.userId, widget.userName,
                      //         controller.text)
                      setState(() {
                        _isLoading = true;
                      });
                      _createNewGroup(
                              widget.userId, widget.userName, controller.text)
                          .whenComplete(() => Navigator.of(context).pop());
                    },
                    isImageButton: false,
                    icon: Icon(Icons.add),
                  ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Tạo nhóm',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            CircleButton(
              buttonColor: AppColors.lightBlue.withOpacity(0.8),
              onPressed: () {
                Navigator.of(context).pop();
              },
              imageAsset: 'assets/images/cancel.png',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hủy',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ],
      actionsPadding: EdgeInsets.symmetric(vertical: 10),
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'Tên nhóm',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          enterName(context),
        ],
      ),
    );
  }

  Widget enterName(context) => Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
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
}
