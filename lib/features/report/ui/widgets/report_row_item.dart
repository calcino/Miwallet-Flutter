import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';

class ReportRowItem extends StatelessWidget {
  final Color backgroundColor;
  final String title, value;

  const ReportRowItem(
      {Key key,
      this.backgroundColor = Colors.white,
      @required this.title,
      @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: ColorRes.blueColor,
                fontSize: ScreenUtil().setSp(DimenRes.normalText)),
          ),
          Text(value,
              style: TextStyle(
                  color: ColorRes.blueColor,
                  fontSize: ScreenUtil().setSp(DimenRes.normalText))),
        ],
      ),
    );
  }
}
