import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_it/service/database_service.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({
    Key? key,
    required this.address,
    required this.birthday,
    required this.department,
    required this.fullName,
    required this.session,
  }) : super(key: key);

  final String fullName;
  final String department;
  final int session;
  final String address;
  final DateTime birthday;

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  bool _isLoading = false;
  String? department;
  String fullName = '';
  String session = '';
  String address = '';

  DateTime birthDay = DateTime.now();
  String? valueChoose;
  final List<String> listItem = [
    'Công nghệ Phần mềm',
    'Hệ thống Thông tin',
    'Kỹ thuật Máy tính',
    'MMT & Truyền thông',
    'Khoa học Máy tính',
    'Khoa học và Kỹ thuật Thông tin'
  ];

  final _formField = GlobalKey<FormState>();
  bool isEnable = false;

  void submitForm(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_formField.currentState!.validate()) {
      try {
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .updateUserInfoData(fullName, department as String,
                int.parse(session), address, birthDay);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      _isLoading = false;
    });
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
                child: Text('Done'),
              ),
              Expanded(
                  child: CupertinoDatePicker(
                onDateTimeChanged: (date) {
                  setState(() {
                    birthDay = date;
                  });
                },
                mode: CupertinoDatePickerMode.date,
                initialDateTime: birthDay,
              ))
            ],
          ),
        );
      });

  Widget buildDatePicker() {
    String label = 'Ngày Sinh';
    return Container(
      child: Column(
        children: <Widget>[
          if (label.isNotEmpty)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              // margin: EdgeInsets.only(right: 170),
              child: Text(
                'Ngày sinh',
                style: AppTextStyles.labelTextField,
                textAlign: TextAlign.start,
              ),
            ),
          Container(
            padding: EdgeInsets.only(right: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy').format(birthDay),
                ),
                IconButton(
                  onPressed: () {
                    openCupertino();
                  },
                  icon: Icon(Icons.date_range_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    birthDay = widget.birthday;
    fullName = widget.fullName;
    department = widget.department;
    session = widget.session.toString();
    address = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: TextButton(
          child: const Text(
            'Huỷ',
            style: AppTextStyles.appbarButtonTitle,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: AppTextStyles.sectionTitle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formField.currentState!.validate()) {
                print('hi');
                submitForm(context);
              } else {
                print('error');
              }
            },
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Lưu',
                    style: AppTextStyles.appbarButtonTitle,
                  ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.lineColor,
            height: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formField,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                initialValue: fullName,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Tên',
                  labelStyle: AppTextStyles.labelTextField,
                  errorBorder: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng nhập đầy đủ';
                  }
                  if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return 'Sai cú pháp';
                  }
                  return null;
                },
                onChanged: (value) {
                  fullName = value;
                },
              ),
              DropdownButtonFormField(
                isExpanded: true,
                hint: Text(
                  '--Chọn--',
                  style: AppTextStyles.body,
                ),
                value: department,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Khoa',
                  labelStyle: AppTextStyles.labelTextField,
                  errorBorder: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                onChanged: (value) => {
                  setState(() {
                    department = value as String;
                  })
                },
                items: listItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
              TextFormField(
                initialValue:
                    int.parse(session) == -1 ? '' : session.toString(),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Khoá',
                  labelStyle: AppTextStyles.labelTextField,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng nhập đầy đủ';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Chỉ nhập số';
                  }
                  return null;
                },
                onChanged: (value) {
                  session = value;
                },
              ),
              TextFormField(
                initialValue: widget.address,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nơi ở',
                  labelStyle: AppTextStyles.labelTextField,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng nhập đầy đủ';
                  }
                  return null;
                },
                onChanged: (value) {
                  address = value;
                },
              ),
              buildDatePicker(),
            ],
          ),
        ),
      ),
    );
  }
}
