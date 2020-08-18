import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';

class EmptyReportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Strings.emptyData,
            style: TextStyle(
                color: ColorRes.blueColor,
                fontSize: ScreenUtil().setSp(DimenRes.largeText)),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(30),
          ),
          SvgPicture.asset(
            'assets/images/analysis.svg',
            width: ScreenUtil().setWidth(160),
          ),
        ],
      ),
    );
  }
}
