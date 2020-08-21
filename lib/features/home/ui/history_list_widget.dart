import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../../repository/db/views/account_transaction_view.dart';
import '../../../utils/date_range.dart';
import '../../../utils/income_expense.dart';
import '../../../utils/widgets/empty_data_widget.dart';
import '../../../utils/widgets/total_income_expense.dart';
import '../logic/home_provider.dart';
import 'widgets/history_header_widget.dart';
import 'widgets/history_item_widget.dart';

class HistoryListWidget extends StatelessWidget {
  final DateRange dateRange;
  HomeProvider _homeProvider;

  HistoryListWidget({Key key, @required this.dateRange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.getAllTransaction(dateRange: dateRange);

    ScreenUtil.init(width: 320, height: 640);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[_content(), _loadingWidget()],
    );
  }

  Widget _content() {
    return Selector<HomeProvider, List<AccountTransactionView>>(
        selector: (_, provider) => provider.transactions,
        builder: (_, data, __) {
          return _buildList(data);
        });
  }

  Widget _loadingWidget() {
    return Selector<HomeProvider, bool>(
        selector: (_, provider) => provider.isLoading,
        builder: (_, loading, __) {
          return loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container();
        });
  }

  Widget _buildList(List<AccountTransactionView> data) {
    final String headSign = '1000-01-20 00:00:00.000';
    var incomeExpense = IncomeExpense(income: 0, expense: 0);
    if (data != null && data.isNotEmpty) {
      incomeExpense = _homeProvider.getTotalIncomeExpense(data);
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
              if (headSign == dateTime.toString()) {
                return TotalIncomeExpense(incomeExpense: incomeExpense);
              } else {
                var totals = _homeProvider.getTotalIncomeExpense(data,
                    dateRange: dateRange);
                var groupIncome = totals.income;
                var groupExpense = totals.expense;
                return HistoryHeaderWidget(
                  dateTime: dateTime,
                  sumOfExpense: groupExpense,
                  sumOfIncome: groupIncome,
                );
              }
            },
            indexedItemBuilder: (ctx, element, index) {
              return element.accountId != null
                  ? HistoryItemWidget(
                      accountTransaction: element,
                      isLastItem: index == data.length - 1)
                  : Container();
            },
          );
  }
}
