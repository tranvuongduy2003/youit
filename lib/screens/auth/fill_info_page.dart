import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/themes/app_colors.dart';
import '../../config/route/routes.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseFireStore = FirebaseFirestore.instance;

class FillInfoPage extends StatefulWidget {
  const FillInfoPage({super.key});

  @override
  State<FillInfoPage> createState() => _FillInfoPageState();
}

class _FillInfoPageState extends State<FillInfoPage> {
  DateTime _dateTime = DateTime.now();
  String? _valueChoose;
  List listItem = [
    'Công nghệ Phần mềm',
    'Hệ thống Thông tin',
    'Kỹ thuật Máy tính',
    'MMT & Truyền thông',
    'Khoa học Máy tính',
    'Khoa học và Kỹ thuật Thông tin'
  ];

  void _handleUpdateInfo(context) async {
    try {
      CollectionReference users = _firebaseFireStore.collection('users');
      await users.doc(_firebaseAuth.currentUser?.uid).update({
        'dob': _dateTime,
        'khoa': _valueChoose,
        'isOnline': true,
        'updatedAt': DateTime.now(),
      });
      Navigator.of(context).pushNamed(Routes.bottomNavBarWithGroupListPage);
    } catch (e) {
      print(e);
    }
  }

  void openCupertino() => showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Done')),
              Expanded(
                child: CupertinoDatePicker(
                  onDateTimeChanged: (date) {
                    setState(() {
                      _dateTime = date;
                    });
                  },
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _dateTime,
                ),
              )
            ],
          ),
        );
      });

  Widget buildDatePicker() {
    String label = 'Ngày Sinh';
    return Container(
      child: Column(
        children: <Widget>[
          if (label != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.only(bottom: 10),
              // margin: EdgeInsets.only(right: 170),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateFormat('dd-MM-yyyy').format(_dateTime)),
                IconButton(
                  onPressed: () {
                    openCupertino();
                  },
                  icon: Icon(Icons.date_range_rounded),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComboBox() {
    String label = 'Khoa';
    return Container(
      child: Column(
        children: <Widget>[
          if (label != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.only(bottom: 10),
              // margin: EdgeInsets.only(right: 170),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Colors.white,
            ),
            child: DropdownButton(
              isExpanded: true,
              hint: Text('--Chọn--'),
              value: _valueChoose,
              onChanged: (value) => {
                setState(() {
                  _valueChoose = value as String?;
                })
              },
              items: listItem.map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem, child: Text(valueItem));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                ///  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80, bottom: 50),
                    child: Text(
                      'Đăng kí thành công!\nĐiền thông tin\ncá nhân của bạn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        buildDatePicker(),
                        SizedBox(
                          height: 20,
                        ),
                        buildComboBox(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text('Bỏ qua'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20)),
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor:
                                  MaterialStatePropertyAll(AppColors.white),
                              foregroundColor: MaterialStatePropertyAll(
                                  AppColors.primaryColor)),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(Routes.homePage),
                        ),
                        ElevatedButton(
                          child: Text('Cập nhật'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20)),
                              elevation: MaterialStatePropertyAll(0),
                              foregroundColor:
                                  MaterialStatePropertyAll(AppColors.white),
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColors.primaryColor)),
                          onPressed: () => _handleUpdateInfo(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
