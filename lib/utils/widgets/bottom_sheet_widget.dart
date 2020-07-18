import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';

Widget categoryAppBar(String title, bool isBackable, BuildContext context,) {
  return Container(
    decoration: BoxDecoration(
      color: ColorRes.blueColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(ScreenUtil().setWidth(25),),),
    ),
    height: ScreenUtil().setHeight(60.78),
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(23),
              color: Colors.white,
            ),
          ),
        ),
        Visibility(
          visible: isBackable,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop()),
          ),
        ),
      ],
    ),
  );
}

Widget categoryListField(String name,{IconData icon = Icons.image}) {
  ScreenUtil.init(width: 360, height: 640);
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(
      horizontal: ScreenUtil().setWidth(21),
    ),
    height: ScreenUtil().setHeight(51),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: ScreenUtil().setWidth(31),
          color: ColorRes.blueColor,
        ),
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        Text(
          name,
          style: TextStyle(fontSize: ScreenUtil().setSp(14), color: ColorRes.hintColor),
        ),
      ],
    ),
  );
}
