import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';

class EditWallet extends StatefulWidget {
  @override
  _EditWalletState createState() => _EditWalletState();
}

class _EditWalletState extends State<EditWallet> {
  bool isSavaing = true;
  bool isShowing = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, bottomCalcAppBar(), editWallet),
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
            width: 318,
            label: accountName,
            childWidget: chooseBottomSheet("Saderat"),
          ),
          customTextBox(
            marginTop: 10,
            width: 318,
            label: bank,
            childWidget: chooseBottomSheet(choose),
            onPressed: () {
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
                  return _chooseBankBtmSheet(context);
                },
              );
            },
          ),
          customTextBox(
            marginTop: 10,
            width: 318,
            label: description,
            marginBottom: 0,
            height: 84,
            childWidget: descTextField(),
          ),
          switchBoxRow(savingsAccount, isSavaing,
              onChanged: (bool) => setState(() {
                    isSavaing = !isSavaing;
                  })),
          switchBoxRow(showInTotalBalance, isShowing,
              onChanged: (bool) => setState(() {
                isShowing = !isShowing;
              })),
        ],
      ),
    );
  }

  Widget _chooseBankBtmSheet(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(selectBank, false, context),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    categoryListField("Melli"),
                    Divider(
                      color: hintColor,
                      height: ScreenUtil().setHeight(1),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget switchBoxRow(String text, bool value, {Function onChanged}) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(27),
        left: ScreenUtil().setWidth(37),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style:
                TextStyle(fontSize: ScreenUtil().setSp(14), color: blueColor),
          ),
          CupertinoSwitch(
            activeColor: blueColor,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
