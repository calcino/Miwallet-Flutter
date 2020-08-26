import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';
import '../../../../utils/custom_models/filter_transactions_model.dart';
import 'report_bottom_app_bar.dart';

class ReportAppBar extends AppBar {
  final VoidCallback callback;
  final FilterTransactionModel filterTransactionModel;

  ReportAppBar({@required this.filterTransactionModel, this.callback});

  @override
  Widget get title => Text(
        Strings.reports,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(DimenRes.normalText),
            color: Colors.white),
      );

  @override
  bool get centerTitle => true;

  @override
  List<Widget> get actions => <Widget>[
        InkWell(
          onTap: callback,
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              height: ScreenUtil().setWidth(18),
              width: ScreenUtil().setWidth(18),
              fit: BoxFit.fitWidth,
              color: Colors.white,
            ),
          ),
        ),
      ];

  @override
  Widget get leading => InkWell(
        onTap: () {
          //todo handle on tap
        },
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
          child: SvgPicture.asset(
            'assets/images/report.svg',
            width: ScreenUtil().setWidth(12),
            height: ScreenUtil().setWidth(12),
            fit: BoxFit.fitWidth,
            color: Colors.white,
          ),
        ),
      );

  @override
  PreferredSizeWidget get bottom => PreferredSize(
        preferredSize: Size(double.infinity, kBottomNavigationBarHeight),
        child: ReportBottomAppBar(
            selectedDate: filterTransactionModel.dateRange.toString(),
            filtered: [
              filterTransactionModel?.category?.name ?? '',
              filterTransactionModel?.wallet?.name ?? '',
              filterTransactionModel?.user?.firstName ?? ''
            ]),
      );

  @override
  Size get preferredSize =>
      Size(double.infinity, 2.25 * kBottomNavigationBarHeight);
}
