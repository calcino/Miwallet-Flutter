import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/custom_paint/custom_rock_painter.dart';

class EmptyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          Strings.emptyData,
          style: TextStyle(
              color: ColorRes.blueColor,
              fontSize: ScreenUtil().setSp(DimenRes.largeText)),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        _rockWidget(),
      ],
    );
  }

  Widget _rockWidget() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: ScreenUtil().setHeight(300),
          width: double.infinity,
          child: CustomPaint(
            painter: CustomRockPainter(),
          ),
        ));
  }
}
