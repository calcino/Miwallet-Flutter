
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';

Widget errorTextWidget(bool isVisible,String errorText){
  return Visibility(
    visible: isVisible,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(5),left: ScreenUtil().setWidth(21)),
        child: Text(errorText,style: TextStyle(color: ColorRes.redColor),),
      ),
    ),
  );
}