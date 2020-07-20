import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

Widget showDatePickerWidget(BuildContext context,DateTimePickerMode pickerMode,String dateFormat,Function(DateTime,List<int>) onConfirm) {
  DatePicker.showDatePicker(
    context,
    pickerMode: pickerMode,
    dateFormat: dateFormat,
    onConfirm: onConfirm
  );
}