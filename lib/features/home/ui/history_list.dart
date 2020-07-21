import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/features/home/logic/history_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/string_extentions.dart';
import 'package:fluttermiwallet/utils/widgets/empty_data_widget.dart';
import 'package:fluttermiwallet/utils/widgets/total_income_expnse.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatelessWidget {
  final DateTime fromDate, toDate;
  HistoryProvider _historyProvider;

  HistoryList({Key key, @required this.fromDate, @required this.toDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    _historyProvider =
        HistoryProvider(db: appProvider.db, fromDate: fromDate, toDate: toDate);
    return StreamBuilder<List<AccountTransactionView>>(
        stream: _historyProvider.getAllTransaction(),
        initialData: null,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildList(List<AccountTransactionView> data) {
    final String headSign = '1000-01-20 00:00:00.000';
    var totalIncome = 0.0;
    var totalExpense = 0.0;
    if (data != null && data.isNotEmpty) {
      var incomeExpense = _historyProvider.getTotalIncomeExpense(data);
      totalIncome = incomeExpense[0];
      totalExpense = incomeExpense[1];
    }
    return data.isEmpty
        ? EmptyDataWidget()
        : GroupedListView<AccountTransactionView, DateTime>(
            elements: data..add(AccountTransactionView(dateTime: headSign)),
            groupBy: (AccountTransactionView item) {
              var dateTime = DateTime.parse(item.dateTime);
              return DateTime(dateTime.year, dateTime.month, dateTime.day);
            },
            groupSeparatorBuilder: (dateTime) {
              //print("fucking: $dateTime");
              if (headSign == dateTime.toString()) {
                return TotalIncomeExpense(
                    income: totalIncome, expense: totalExpense);
              } else {
                var totals = _historyProvider.getTotalIncomeExpense(
                    data, DateFormat('yyyy-MM-dd').format(dateTime));
                var groupIncome = totals[0];
                var groupExpense = totals[1];
                return _HistoryHeader(
                  dateTime: dateTime,
                  sumOfExpense: groupExpense,
                  sumOfIncome: groupIncome,
                );
              }
            },
            indexedItemBuilder: (ctx, element, index) {
              return element.accountId != null
                  ? _HistoryItem(
                      accountTransaction: element,
                      isLastItem: index == data.length - 1)
                  : Container();
            },
          );
  }
}

class _HistoryItem extends StatelessWidget {
  final AccountTransactionView accountTransaction;
  final bool isLastItem;

  const _HistoryItem(
      {Key key, @required this.accountTransaction, this.isLastItem = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(15),
          right: ScreenUtil().setWidth(15),
          bottom: isLastItem ? ScreenUtil().setWidth(12) : 0),
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
                '${accountTransaction.categoryName}',
                style: TextStyle(
                    color: ColorRes.blueColor,
                    fontSize: ScreenUtil().setSp(DimenRes.smallText)),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Text(
                '${accountTransaction.subcategoryName}',
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
                        '${accountTransaction.amount.toString().split('.')[0].addSeparator()}' +
                        '.' +
                        '${accountTransaction.amount.toString().split('.')[1]}',
                    style: TextStyle(
                        color: accountTransaction.isIncome
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
                '${DateFormat('HH:mm').format(DateTime.parse(accountTransaction.dateTime))}',
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
