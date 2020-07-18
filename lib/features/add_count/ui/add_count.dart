import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/features/add_count/logic/add_count_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_time_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCount extends StatefulWidget {
  @override
  _AddCountState createState() => _AddCountState();
}

class _AddCountState extends State<AddCount> {
  DateTime _time;
  DateTime _date;
  PickedFile _imageFile;
  ImagePicker _pickedFile = ImagePicker();
  bool _isPicked = false;
  AddCountProvider _provider;
  bool _isCategorySelected = false;
  bool _isSubCategorySelected = false;
  String _catNameSelected = Strings.choose;
  String _subCatSelected = Strings.choose;
  double _amount;
  String _description;

  @override
  void initState() {
//    _provider = Provider.of<AddCountProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      width: 360,
      height: 640,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, bottomCalcAppBar(), Strings.addExpense,
            saveOnTap: () => _provider.insertTransaction(AccountTransaction(
                accountId: null,
                amount: _amount,
                dateTime: _date.toString() + _time.toString(),
                receiptImagePath: null,
                categoryId: null,
                subcategoryId: null,
                createdDateTime: null,
                isIncome: null))),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          customTextBox(
              marginTop: 19,
              label: Strings.category,
              childWidget: chooseBottomSheet(Strings.choose),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        ScreenUtil().setWidth(25),
                      ),
                    ),
                  ),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return _chooseCategoryBtmSheet();
                  },
                );
              }),
          customTextBox(
            marginTop: 13,
            marginBottom: 13,
            label: Strings.subcategory,
            childWidget: chooseBottomSheet(Strings.choose),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.time,
                  marginRight: 3.5,
                  childWidget: dateTimeShow(
                    _time == null ? "00:00" : DateFormat("HH:mm").format(_time),
                  ),
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
            marginTop: 15,
            label: Strings.fromWhichAccount,
            childWidget: chooseBottomSheet('Saderat'),
          ),
          customTextBox(
            marginTop: 12,
            label: Strings.description,
            marginBottom: 23.5,
            height: 84,
            childWidget: descTextField((text) => _description = text),
          ),
          Divider(
            height: ScreenUtil().setWidth(1),
            color: ColorRes.hintColor,
          ),
          _imagePickerButton(),
        ],
      ),
    );
  }

  void showBtmSheet(Widget bottomSheetUi){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            ScreenUtil().setWidth(25),
          ),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return bottomSheetUi;
      },
    );
  }

  Widget _imagePickerButton() {
    return Container(
        width: ScreenUtil().setWidth(283),
        height: ScreenUtil().setHeight(113),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _isPicked ? ColorRes.hintColor : Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          bottom: ScreenUtil().setHeight(64),
          right: ScreenUtil().setWidth(18),
          left: ScreenUtil().setWidth(18),
        ),
        child: _setImageView());
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

  _chooseCategoryBtmSheet() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.chooseCategory,context),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Divider(
                      color: ColorRes.hintColor,
                      height: ScreenUtil().setHeight(1),
                    ),
                    index == 0
                        ? categoryListField(Strings.addNewCategory,
                            icon: Icons.add,onTap: (){showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                ScreenUtil().setWidth(25),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return _addCategoryBtmSheet();
                          },
                        );})
                        : categoryListField("Food"),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _addCategoryBtmSheet() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(100),
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.addCategory,context,isBackable: true,hasDone: true),
          _labelText(Strings.nameCategory, marginTop: 20, marginBottom: 6),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setHeight(36),
            ),
            child: TextField(
              style: TextStyle(
                color: ColorRes.hintColor,
                fontSize: ScreenUtil().setSp(12),
              ),
              maxLines: 1,
              decoration: InputDecoration(),
            ),
          ),
          _labelText(Strings.chooseAnIcon, marginTop: 15, marginBottom: 17),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setHeight(36),
              ),
              child: GridView.count(
                crossAxisCount: 6,
                children: List.generate(30, (index) => Icon(Icons.image)),
              ),
            ),
          ),
        ],
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

  _labelText(String label, {double marginTop, double marginBottom}) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(marginTop),
        bottom: ScreenUtil().setHeight(marginBottom),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setHeight(36),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: ColorRes.blueColor,
          fontSize: ScreenUtil().setSp(14),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    PickedFile _picture =
        await _pickedFile.getImage(source: ImageSource.gallery);

    if (_picture != null) {
      this.setState(() {
        _isPicked = true;
        _imageFile = _picture;
      });
    }
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    PickedFile _img = await _pickedFile.getImage(source: ImageSource.camera);
    if (_img != null) {
      this.setState(() {
        _isPicked = true;
        _imageFile = _img;
      });
    }
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile.path),
        alignment: Alignment.center,
        fit: BoxFit.cover,
      );
    } else {
      return InkWell(
        onTap: () => _showSelectionDialog(context),
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
  }
}
