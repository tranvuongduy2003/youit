import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({Key? key}) : super(key: key);

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  String name = '';
  String department = 'Khoa học máy tính';
  String session = '';
  String address = 'Bình Dương';
  DateTime birthDay = DateTime.now();
  String? valueChoose;
  List listItem = [
    'Công nghệ phần mềm',
    'Khoa học máy tính',
    'Hệ thống thông tin'
  ];

  final _formField = GlobalKey<FormState>();
  bool isEnable = false;

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
          if (label != null)
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
                Text(DateFormat('dd-MM-yyyy').format(birthDay)),
                IconButton(
                    onPressed: () {
                      openCupertino();
                    },
                    icon: Icon(Icons.date_range_rounded))
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
                return Navigator.of(context).pop();
              } else {
                print('error');
              }
            },
            child: const Text(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Tên',
                    labelStyle: AppTextStyles.labelTextField,
                    errorBorder: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập đầy đủ";
                    }
                    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Sai cú pháp";
                    }
                  },
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  hint: Text(
                    '--Chọn--',
                    style: AppTextStyles.body,
                  ),
                  value: (department != '') ? department : null,
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
                        value: valueItem, child: Text(valueItem));
                  }).toList(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Khoá',
                    labelStyle: AppTextStyles.labelTextField,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập đầy đủ";
                    }
                    if (!RegExp(r'^[0-9]$').hasMatch(value)) {
                      return "Chỉ nhập số";
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      session = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nơi ở',
                    labelStyle: AppTextStyles.labelTextField,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập đầy đủ';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
                buildDatePicker()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
