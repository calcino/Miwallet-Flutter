import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/db/entity/cost_history.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/string_extentions.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Column(
      children: <Widget>[
        _header(),
        _sectionedList(),
      ],
    );
  }

  Widget _sectionedList() {
    final fakeList = CostHistory.generateFakeData();
    return Expanded(
        flex: 10,
        child: GroupedListView<CostHistory, DateTime>(
          elements: fakeList,
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
        ));
  }

  Widget _header() {
    Widget _divider() {
      return VerticalDivider(
        color: Colors.grey[300],
        thickness: 1,
        width: 2,
      );
    }

    Widget _globalCostWidget({bool isIncome = true, double amount = 0.0}) {
      IconData _iconData = isIncome ? Icons.arrow_downward : Icons.arrow_upward;
      Color _arrowColor = isIncome ? blueColor : orangeColor;
      Color _backColor = _arrowColor.withOpacity(0.2);
      Color _amountColor = isIncome ? greenColor : redColor;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(40),
            height: ScreenUtil().setWidth(40),
            decoration: BoxDecoration(
              color: _backColor,
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil().setWidth(6)),
              ),
            ),
            child: Icon(
              _iconData,
              color: _arrowColor,
              size: ScreenUtil().setWidth(20),
            ),
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
                isIncome ? income : expense,
                style: TextStyle(
                  color: blueColor,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Container(
                constraints:
                    BoxConstraints(maxWidth: ScreenUtil().setWidth(70)),
                child: FittedBox(
                  child: Text(
                    '\$' +
                        '${amount.toString().split('.')[0].addSeparator()}' +
                        '.' +
                        '${amount.toString().split('.')[1]}',
                    style: TextStyle(color: _amountColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        height: ScreenUtil().setHeight(80),
        margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(20),
            left: ScreenUtil().setWidth(15),
            right: ScreenUtil().setWidth(15),
            bottom: ScreenUtil().setWidth(0)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                ScreenUtil().setWidth(6),
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], offset: Offset(0, 2), blurRadius: 7)
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _globalCostWidget(isIncome: true, amount: 1000000),
            _divider(),
            _globalCostWidget(isIncome: false, amount: 4000.67463),
          ],
        ),
      ),
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
                    color: blueColor, fontSize: ScreenUtil().setSp(smallText)),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Text(
                costHistory.subtitle,
                style: TextStyle(
                  color: blueColor,
                  fontSize: ScreenUtil().setSp(verySmallText),
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
                            ? greenColor
                            : redColor),
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
                  color: blueColor,
                  fontSize: ScreenUtil().setSp(verySmallText),
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
          color: veryLightBlueColor,
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
                color: blueColor, fontSize: ScreenUtil().setSp(normalText)),
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
                    income,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(smallText)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(5),
                  ),
                  Text(
                    expense,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: ScreenUtil().setSp(smallText),
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
