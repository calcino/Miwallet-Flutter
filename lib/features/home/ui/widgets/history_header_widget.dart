import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../utils/extentions/string_extentions.dart';
import '../.././../../res/colors.dart';
import '../.././../../res/dimen.dart';
import '../.././../../res/strings.dart';

class HistoryHeaderWidget extends StatelessWidget {
  final DateTime dateTime;
  final double sumOfIncome;
  final double sumOfExpense;

  const HistoryHeaderWidget(
      {Key key,
      @required this.dateTime,
      @required this.sumOfIncome,
      @required this.sumOfExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setWidth(20),
          left: ScreenUtil().setWidth(15),
          right: ScreenUtil().setWidth(15)),
      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
      decoration: BoxDecoration(
          color: ColorRes.veryLightBlueColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[350], offset: Offset(0, -2), blurRadius: 4)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(6)),
              topLeft: Radius.circular(ScreenUtil().setWidth(6)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateFormat('EEEE, dd MMM').format(dateTime),
            style: TextStyle(
                color: ColorRes.blueColor,
                fontSize: ScreenUtil().setSp(DimenRes.normalText)),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(9),
          ),
          Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Strings.income,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(DimenRes.smallText)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(5),
                  ),
                  Text(
                    Strings.expense,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: ScreenUtil().setSp(DimenRes.smallText),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: ScreenUtil().setWidth(90)),
                    child: FittedBox(
                      child: Text(
                        '\$' +
                            '${sumOfIncome.toString().split('.')[0].addSeparator()}' +
                            '.' +
                            '${sumOfIncome.toString().split('.')[1]}',
                        style: TextStyle(color: Colors.grey[500]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(5),
                  ),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: ScreenUtil().setWidth(90)),
                    child: FittedBox(
                      child: Text(
                        '\$' +
                            '${sumOfExpense.toString().split('.')[0].addSeparator()}' +
                            '.' +
                            '${sumOfExpense.toString().split('.')[1]}',
                        style: TextStyle(color: Colors.grey[500]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
