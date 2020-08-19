import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../res/strings.dart';

class ReportExportPopup extends StatelessWidget {
  final TextEditingController _textEditingController =
      TextEditingController(text: 'report.pdf');

  final Function(String) onExportClicked;

  ReportExportPopup({Key key, this.onExportClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _content(context),
              _headLogo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(250),
      height: ScreenUtil().setHeight(150),
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(12),
          vertical: ScreenUtil().setWidth(2)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setWidth(8)),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey[400], blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: ScreenUtil().setWidth(35),
          ),
          _titleWidget(),
          _fileNameField(),
          _actionButtonsWidget(context),
        ],
      ),
    );
  }

  Widget _actionButtonsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _cancelButton(context),
        _exportButton(),
      ],
    );
  }

  Widget _titleWidget() {
    return Text(
      Strings.exportReport,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ColorRes.blueColor,
        fontSize: ScreenUtil().setSp(DimenRes.normalText),
      ),
    );
  }

  Widget _fileNameField() {
    return TextField(
      controller: _textEditingController,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: ScreenUtil().setSp(DimenRes.smallText),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setWidth(4)),
        ),
        side: BorderSide(color: ColorRes.blueColor),
      ),
      minWidth: ScreenUtil().setWidth(100),
      child: Text(
        Strings.cancel,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorRes.blueColor,
          fontSize: ScreenUtil().setSp(DimenRes.normalText),
        ),
      ),
    );
  }

  Widget _exportButton() {
    return MaterialButton(
      onPressed: _onExportButtonClicked,
      color: ColorRes.blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setWidth(4)),
        ),
      ),
      minWidth: ScreenUtil().setWidth(100),
      child: Text(
        Strings.export,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(DimenRes.normalText),
        ),
      ),
    );
  }

  _onExportButtonClicked() {
    if (_textEditingController.text == null ||
        _textEditingController.text.isEmpty) {
      return;
    }
    var fileName = _textEditingController.text;
    fileName = fileName.endsWith('.pdf') ? fileName : fileName + '.pdf';
    onExportClicked(fileName);
  }

  Widget _headLogo() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setWidth(60),
      decoration: BoxDecoration(
          color: ColorRes.blueColor,
          borderRadius: BorderRadius.all(Radius.circular(500)),
          boxShadow: [
            BoxShadow(color: Colors.grey[300], blurRadius: 5, spreadRadius: 1)
          ]),
      child: Icon(
        Icons.file_upload,
        color: Colors.white,
        size: ScreenUtil().setWidth(28),
      ),
    );
  }
}
