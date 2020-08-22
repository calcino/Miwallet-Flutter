import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';

Widget boxRow(String text,
    {Function onChanged,
    double paddingRight = 16,
    double paddingLeft = 9,
    double marginTop = 0,
    double marginBottom = 0,
    Widget secondWidget,
    Color color = ColorRes.boxColor,
    double height = 46}) {
  return Container(
    height: height,
    padding: EdgeInsets.only(
      right: ScreenUtil().setWidth(paddingRight),
      left: ScreenUtil().setWidth(paddingLeft),
    ),
    margin: EdgeInsets.only(
      right: ScreenUtil().setWidth(21),
      left: ScreenUtil().setWidth(21),
      top: ScreenUtil().setHeight(marginTop),
      bottom: ScreenUtil().setHeight(marginBottom),
    ),
    color: color,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(14), color: ColorRes.blueColor),
        ),
        secondWidget
      ],
    ),
  );
}
