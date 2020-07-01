import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddCount extends StatefulWidget {
  @override
  _AddCountState createState() => _AddCountState();
}

class _AddCountState extends State<AddCount> {
  Color _toolbarColor = Color(0xff1565C0);

  Color _textColor = Color(0xff0D47A1);

  Color _hintColor = Color(0xff707070);

  DateTime _time;

  DateTime _date;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      width: 360,
      height: 640,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: _toolbarColor,
      elevation: 0,
      title: Text(
        "Add Expense",
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(20),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            right: ScreenUtil().setWidth(21),
          ),
          child: GestureDetector(
            child: Text(
              "save",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(14),
              ),
            ),
          ),
        ),
      ],
      leading: InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      bottom: _calcField(),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _fieldBox(
            marginTop: 19,
            width: 318,
            label: "Category",
            childWidget: _chooseBottomSheet("Choose"),
          ),
          _fieldBox(
            marginTop: 13,
            marginBottom: 13,
            width: 318,
            label: "Subcategory",
            childWidget: _chooseBottomSheet("Choose"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _fieldBox(
                marginTop: 0,
                width: 156,
                label: "Time",
                marginRight: 0,
                childWidget: _dateTimeShow(_time == null
                    ? "00:00"
                    : DateFormat("HH:mm").format(_time)),
                onPressed: () => _showTimePicker(),
              ),
              _fieldBox(
                marginTop: 0,
                width: 156,
                label: "Date",
                marginLeft: 0,
                childWidget: _dateTimeShow(
                  _date == null
                      ? DateFormat('dd MMMM,yyyy').format(
                          DateTime.now(),
                        )
                      : DateFormat("dd MMMM,yyyy").format(_date),
                ),
                onPressed: () => _showDatePicker(),
              ),
            ],
          ),
          _fieldBox(
            marginTop: 15,
            width: 318,
            label: "From Which Account",
            childWidget: _chooseBottomSheet("Saderat"),
          ),
          _fieldBox(
            marginTop: 12,
            width: 318,
            label: "Description",
            marginBottom: 23.5,
            height: 84,
            childWidget: _descTextField(),
          ),
          Divider(
            height: ScreenUtil().setWidth(1),
            color: _hintColor,
          ),
          _imagePickerButton(),
        ],
      ),
    );
  }

  Widget _imagePickerButton() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.5),
        bottom: ScreenUtil().setHeight(61),
      ),
      child: Image(
        image: AssetImage(
          "assets/images/image_picker.png",
        ),
        fit: BoxFit.cover,
        width: ScreenUtil().setWidth(92),
        height: ScreenUtil().setHeight(75),
      ),
    );
  }

  Widget _fieldBox(
      {double width,
      double height = 50.0,
      marginTop,
      marginBottom = 0,
      marginRight = 21,
      marginLeft = 21,
      String label,
      Widget childWidget,
      Function onPressed}) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(marginTop),
          bottom: ScreenUtil().setHeight(marginBottom),
          right: ScreenUtil().setWidth(marginRight),
          left: ScreenUtil().setWidth(marginLeft)),
      height: ScreenUtil().setHeight(height),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setHeight(height - 14),
              child: OutlineButton(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                onPressed: onPressed,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightedBorderColor: _hintColor,
                color: _textColor,
                borderSide: BorderSide(
                  color: _toolbarColor.withOpacity(0.55),
                ),
                disabledBorderColor: _toolbarColor.withOpacity(0.55),
                child: childWidget,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: FittedBox(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(4),
                ),
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(11),
                ),
                height: ScreenUtil().setHeight(19),
                color: Colors.white,
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14), color: _textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _calcField() {
    return PreferredSize(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(21)),
        color: _toolbarColor,
        height: ScreenUtil().setHeight(156),
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
            bottom: ScreenUtil().setWidth(10),
            top: ScreenUtil().setWidth(10),
          ),
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(64),
          ),
          width: ScreenUtil().setWidth(318),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(13),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Amount",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14), color: _textColor),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "\$0.00",
                  suffixIcon: Image.asset("assets/images/calculator.png",),
                  counterStyle: TextStyle(
                    color: Color(0xff0D47A1),
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size(
        ScreenUtil().setWidth(318),
        ScreenUtil().setHeight(156),
      ),
    );
  }

  Widget _chooseBottomSheet(String hint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          hint,
          style: TextStyle(fontSize: ScreenUtil().setSp(12), color: _hintColor),
        ),
        Icon(Icons.arrow_drop_down),
      ],
    );
  }

  Widget _dateTimeShow(String dateTime) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        dateTime,
        style: TextStyle(fontSize: ScreenUtil().setSp(12), color: _hintColor),
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

  Widget _descTextField() {
    return TextField(
      minLines: 1,
      maxLines: 6,
      style: TextStyle(fontSize: ScreenUtil().setSp(12), color: _hintColor),
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
