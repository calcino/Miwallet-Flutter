import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_time_widget.dart';
import 'package:intl/intl.dart';

class MoneyTransfer extends StatefulWidget {
  @override
  _MoneyTransferState createState() => _MoneyTransferState();
}

class _MoneyTransferState extends State<MoneyTransfer> {
  DateTime _time;
  DateTime _date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, bottomCalcAppBar(isExpanded: true), Strings.moneyTransfer),
        body: _body(),
      ),
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          customTextBox(
            marginTop: 19,
            marginBottom: 12,
            label: Strings.accountName,
            childWidget: chooseBottomSheet("Saderat"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.time,
                  marginRight: 3.5,
                  childWidget: dateTimeShow(_time == null
                      ? "00:00"
                      : DateFormat("HH:mm").format(_time)),
                  onPressed: () => _showTimePicker(),
                ),
              ),
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.date,
                  marginLeft: 3.5,
                  childWidget: dateTimeShow(
                    _date == null
                        ? DateFormat('dd MMMM,yyyy').format(
                      DateTime.now(),
                    )
                        : DateFormat("dd MMMM,yyyy").format(_date),
                  ),
                  onPressed: () => _showDatePicker(),
                ),
              ),
            ],
          ),
          customTextBox(
            marginTop: 12,
            label: Strings.description,
            marginBottom: 0,
            height: 84,
            childWidget: descTextField(),
          ),

        ],
      ),
    );
  }

  _showTimePicker() {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.time,
      dateFormat: "HH-mm",
      onConfirm: (datetime, list) => setState(
            () {
          _time = datetime;
        },
      ),
    );
  }

  _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      dateFormat: "yyyy-MMMM-dd",
      onConfirm: (datetime, list) => setState(
            () {
          _date = datetime;
        },
      ),
    );
  }
}
