import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';

Widget dateTimeShow(String dateTime) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      dateTime,
      style: TextStyle(fontSize: ScreenUtil().setSp(12), color: hintColor),
    ),
  );
}

 showTimePicker(BuildContext context,{Function onConfirm}) {
   DatePicker.showDatePicker(
    context,
    pickerMode: DateTimePickerMode.time,
    dateFormat: "HH-mm",
    onConfirm: onConfirm
  );
}