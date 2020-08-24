import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';
import '../../../../utils/date_range.dart';
import '../../../../utils/extentions/string_extentions.dart';
import '../../logic/dashboard_provider.dart';
import 'time_period_drop_down.dart';

class BottomBarWidget extends StatelessWidget {
  final Function(DateRange) onSelectDate;

  const BottomBarWidget({Key key, @required this.onSelectDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Strings.totalBalance,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(DimenRes.normalText),
                    color: Colors.white),
              ),
              TimePeriodDropDown(
                onSelectDate: this.onSelectDate,
              ),
            ],
          ),
          _totalBalanceText(),
        ],
      ),
    );
  }

  Widget _totalBalanceText() {
    return Selector<DashboardProvider, double>(
      selector: (_, provider) => provider.totalBalance,
      builder: (ctx, balance, child) {
        var totalBalance = balance.toStringAsFixed(2).split('.');
        return Text(
          '\$${totalBalance[0].addSeparator()}.${totalBalance[1]}',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(DimenRes.largeText),
              fontWeight: FontWeight.bold,
              color: Colors.white),
        );
      },
    );
  }
}
