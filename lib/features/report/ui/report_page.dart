import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermiwallet/features/report/ui/filter_reports_sheet.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_chart.dart';
import 'package:fluttermiwallet/utils/widgets/total_income_expnse.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
      appBar: _appbar(context),
    );
  }

  Widget _body() {
    return Center(
      child: _content([]),
    );
  }

  Widget _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        Strings.reports,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(DimenRes.normalText),
            color: Colors.white),
      ),
      centerTitle: true,
      actions: <Widget>[
        InkWell(
          onTap: () {
            _openFilterReportBottomSheet(context);
          },
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
      ],
      leading: InkWell(
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
      ),
      bottom: _bottomAppbar(context),
    );
  }

  Widget _bottomAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, kBottomNavigationBarHeight),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  Strings.byChoosingDate,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(DimenRes.normalText),
                      color: Colors.white),
                ),
                Spacer(
                  flex: 1,
                ),
                InkWell(
                  onTap: () {
                    //todo handle on tap
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        '01 July - 09 July',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(DimenRes.smallText),
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: ScreenUtil().setWidth(20),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              'Filtered: Food Category   |   Zohre',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(DimenRes.smallText),
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(List<AccountTransactionView> transactions) {
    return Column(
      children: <Widget>[
        TotalIncomeExpense(income: 2000, expense: 289100),
        Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
          height: ScreenUtil().setWidth(200),
          width: ScreenUtil().setWidth(300),
          alignment: Alignment.center,
          child: CustomChart(
            transactions,
            isPointChart: true,
          ),
        ),
        _rowItem(Colors.grey[200], Strings.averageCostPerDay, '\$150'),
        _rowItem(Colors.white, Strings.numberOfTransaction, '100'),
      ],
    );
  }

  Widget _rowItem(Color backgroundColor, String title, String value) {
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

  _openFilterReportBottomSheet(BuildContext context) {
    showModalBottomSheet<int>(
      isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setWidth(30)),
                topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
        builder: (context) {
          return FilterReportsSheet();
        }).then((value) => print('bottomsheet closed with int : $value'));
  }
}
