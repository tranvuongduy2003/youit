import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/themes/app_colors.dart';
import '../../widgets/stateless/input.dart';
import '../../widgets/stateless/sign_button.dart';

class FillInfoPage extends StatefulWidget {
  const FillInfoPage({super.key});

  @override
  State<FillInfoPage> createState() => _FillInfoPageState();
}

class _FillInfoPageState extends State<FillInfoPage> {
  DateTime dateTime = DateTime.now();
  String fullName = "";
  String? valueChoose;
  List listItem = [
    'Công nghệ phần mềm',
    'Khoa học máy tính',
    'Hệ thống thông tin'
  ];

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
                    dateTime = date;
                  });
                },
                mode: CupertinoDatePickerMode.date,
                initialDateTime: dateTime,
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
                  Text(DateFormat('dd-MM-yyyy').format(dateTime)),
                  IconButton(
                      onPressed: () {
                        openCupertino();
                      },
                      icon: Icon(Icons.date_range_rounded))
                ],
              )),
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
              value: valueChoose,
              onChanged: (value) => {
                setState(() {
                  valueChoose = value as String?;
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
                      'Điền thông tin\ncá nhân của bạn',
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
                        Input(
                          exception: r'^[a-z A-Z]+$',
                          label: 'Họ và tên',
                          hintText: 'Nhập họ và tên',
                          textColor: AppColors.fade,
                          textfieldColor: AppColors.white,
                          handleChange: (value) => setState(() {
                            fullName = value;
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        SignButton(
                          buttonText: 'Đăng Ký',
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.white,
                          handleOnPress: () => {},
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
