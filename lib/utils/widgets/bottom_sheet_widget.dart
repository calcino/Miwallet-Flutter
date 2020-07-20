import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';

Widget categoryAppBar(String title,BuildContext context,{ bool isBackable= false,bool hasDone=false, onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: ColorRes.blueColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(ScreenUtil().setWidth(25),),),
    ),
    padding: EdgeInsets.only(right: ScreenUtil().setWidth(21),),
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
        Visibility(
          visible: hasDone,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
                onTap;
                Navigator.pop(context);
              },
              child: Text(
                Strings.ok,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget categoryListField(String name,{IconData icon = Icons.image,bool hasIcon =true,Function onTap}) {
  ScreenUtil.init(width: 360, height: 640);
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(21),
      ),
      height: ScreenUtil().setHeight(51),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: hasIcon,
            child: Icon(
              icon,
              size: ScreenUtil().setWidth(31),
              color: ColorRes.blueColor,
            ),
          ),
          Visibility(
            visible: hasIcon,
            child: SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: ScreenUtil().setSp(14), color: ColorRes.hintColor),
          ),
        ],
      ),
    ),

  );
}

void showModalBottomSheetWidget(BuildContext context,Widget childWidget) {
  showModalBottomSheet(
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
      return childWidget;
    },
  );
}

