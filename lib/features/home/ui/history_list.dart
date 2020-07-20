import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/db/entity/cost_history.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/string_extentions.dart';
import 'package:fluttermiwallet/utils/widgets/total_income_expnse.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return SingleChildScrollView(
      child: Wrap(
        children: List()
          ..add(TotalIncomeExpense(
            expense: 1000,
            income: 398383,
          ))
          ..add(_sectionedList()),
      ),
    );
  }

  Widget _sectionedList() {
    final fakeList = CostHistory.generateFakeData();
    return GroupedListView<CostHistory, DateTime>(
      elements: fakeList,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      groupBy: (CostHistory item) {
        return DateTime.parse(item.createDate);
      },
      groupSeparatorBuilder: (dateTime) {
        return _HistoryHeader(
          dateTime: dateTime,
          sumOfExpense: 48363220.0,
          sumOfIncome: 10000000,
        );
      },
      itemBuilder: (ctx, element) {
        return _HistoryItem(costHistory: element);
      },
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final CostHistory costHistory;

  const _HistoryItem({Key key, @required this.costHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[350], offset: Offset(0, 3), blurRadius: 4)
      ]),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.image,
            size: ScreenUtil().setWidth(35),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(7),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                costHistory.title,
                style: TextStyle(
                    color: ColorRes.blueColor,
                    fontSize: ScreenUtil().setSp(DimenRes.smallText)),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Text(
                costHistory.subtitle,
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontSize: ScreenUtil().setSp(DimenRes.verySmallText),
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
                    BoxConstraints(maxWidth: ScreenUtil().setWidth(70)),
                child: FittedBox(
                  child: Text(
                    '\$' +
                        '${costHistory.amount.toString().split('.')[0].addSeparator()}' +
                        '.' +
                        '${costHistory.amount.toString().split('.')[1]}',
                    style: TextStyle(
                        color: (costHistory.costType == CostType.INCOME)
                            ? ColorRes.greenColor
                            : ColorRes.redColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Text(
                '${DateFormat('HH:mm').format(DateTime.parse(costHistory.createDate))}',
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontSize: ScreenUtil().setSp(DimenRes.verySmallText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryHeader extends StatelessWidget {
  final DateTime dateTime;
  final double sumOfIncome;
  final double sumOfExpense;

  const _HistoryHeader(
      {Key key,
      @required this.dateTime,
      @required this.sumOfIncome,
      @required this.sumOfExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
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
