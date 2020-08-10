import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';

import 'choosing_date_sheet.dart';

class FilterReportsSheet extends StatefulWidget {
  @override
  _FilterReportsSheetState createState() => _FilterReportsSheetState();
}

class _FilterReportsSheetState extends State<FilterReportsSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints(maxHeight: ScreenUtil().setHeight(550)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(30)),
              topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _headerWidget(),
          InkWell(child: _item(Strings.choosingDate),onTap: () {
            _showDateRangePicker();
          },),
          Divider(height: 1,color: Colors.lightBlueAccent,),
          _item(Strings.category),
          Divider(height: 1,color: Colors.lightBlueAccent,),
          _item(Strings.wallets),
          Divider(height: 1,color: Colors.lightBlueAccent,),
          _item(Strings.months),
          Divider(height: 1,color: Colors.lightBlueAccent,),
        ],
      ),
    );
  }

  void _showDateRangePicker(){
    showModalBottomSheet<DatePeriod>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setWidth(30)),
                topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
        builder: (context) {
          return ChoosingDateSheet();
        }).then((value) => print('selected Date : $value'));
  }

  Widget _headerWidget() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorRes.blueColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(20)),
              topLeft: Radius.circular(ScreenUtil().setWidth(20)))),
      child: Text(
        Strings.filters,
        style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(DimenRes.largeText)),
      ),
    );
  }

  Widget _item(String title) {
    return Container(
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      alignment: Alignment.centerLeft,
      child: Text(title,
        style: TextStyle(fontSize: ScreenUtil().setSp(DimenRes.normalText),
            color: Colors.black54),),
    );
  }
}