import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';

Widget appBar(BuildContext context, PreferredSize bottom, String title,{saveOnTap}) {
  ScreenUtil.init(width: 360, height: 640);
  return AppBar(
    elevation: 0,
    title: Text(
      title,
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
          onTap: saveOnTap,
          child: Text(
            Strings.save,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(14),
            ),
          ),
        ),
      ),
    ],
    leading: backButton(context),
    bottom: bottom,
  );
}

Widget bottomCalcAppBar({bool isExpanded=false}) {
  ScreenUtil.init(width: 360, height: 640);
  return PreferredSize(
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(21),
        right: ScreenUtil().setWidth(21),
        top: ScreenUtil().setHeight(5),
      ),
      height: ScreenUtil().setHeight(156),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(isExpanded?
              Strings.from + "Saderat" + Strings.account:"",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14), color: Colors.white),
              ),
              Text(isExpanded?
                "\$1000.00":"",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14), color: Colors.white),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setWidth(10),
              top: ScreenUtil().setWidth(10),
            ),
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(40),
            ),
            height: ScreenUtil().setHeight(70),
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
                Expanded(
                  child: Text(
                    Strings.amount,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14), color: textColor),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "\$0.00",
                      suffixIcon: Image.asset(
                        "assets/images/calculator.png",
                      ),
                      counterStyle: TextStyle(
                        color: Color(0xff0D47A1),
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    preferredSize: Size(
      ScreenUtil().setWidth(318),
      ScreenUtil().setHeight(156),
    ),
  );
}

Widget bottomTextAppBar(Widget firstText,Widget secondText,{marginHorizontal=20}){
  return PreferredSize(
    preferredSize: Size(
      ScreenUtil().setWidth(318),
      ScreenUtil().setHeight(85),
    ),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(marginHorizontal),
      ),
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          firstText,
          secondText,
        ],
      ),
    ),
  );
}

Widget bottomText(String text, {double size = 18, Color color = Colors.white}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: ScreenUtil().setSp(size),
      color: color,
    ),
  );
}

Widget backButton(BuildContext context){
  return InkWell(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Icon(
      Icons.arrow_back,
      color: Colors.white,
    ),
  );
}
