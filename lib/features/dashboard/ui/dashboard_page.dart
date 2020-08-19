import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/repository/db/views/transaction_grouped_by_category.dart';
import 'package:fluttermiwallet/utils/date_range.dart';
import 'package:provider/provider.dart';

import '../../../repository/db/views/account_transaction_view.dart';
import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../res/strings.dart';
import '../../../utils/widgets/custom_chart.dart';
import '../../../utils/widgets/donut_auto_label_chart.dart';
import '../../../utils/widgets/empty_dashboard.dart';
import '../../../utils/widgets/total_income_expense.dart';
import '../logic/dashboard_provider.dart';
import 'widgets/bottom_bar_widget.dart';
import 'widgets/income_expense_history_item.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardProvider _provider;

  @override
  void initState() {
    super.initState();
    var defaultSelectedDateRange = DateRange(
        from: DateTime.now().subtract(Duration(days: 7)).toIso8601String(),
        to: DateTime.now().toIso8601String());
    _provider = Provider.of<DashboardProvider>(context, listen: false);
    _provider.getAccountTransactions(dateRange: defaultSelectedDateRange);
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_provider.repository.insertFakeDataToDB();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _appbar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        Strings.dashboard,
        style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(DimenRes.largeText)),
      ),
      bottom: PreferredSize(
          preferredSize: Size(double.infinity, ScreenUtil().setHeight(70)),
          child: BottomBarWidget(
            onSelectDate: (selectedDate) {
              _provider.getAccountTransactions(dateRange: selectedDate);
            },
          )),
    );
  }

  Widget _body() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _loadingWidget(),
        _content(),
      ],
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Selector<DashboardProvider, bool>(
        selector: (_, provider) => provider.isLoading,
        builder: (_, isLoading, ___) =>
            isLoading ? CircularProgressIndicator() : Container(),
      ),
    );
  }

  Widget _content() {
    return Selector<DashboardProvider, List<AccountTransactionView>>(
      selector: (ctx, provider) => provider.transactions,
      builder: (ctx, List<AccountTransactionView> transactions, child) {
        if (transactions == null || transactions.isEmpty) {
          return EmptyDashboard();
        } else {
          return ListView.builder(
            itemBuilder: (_, index) {
              if (index == 0) {
                return TotalIncomeExpense(
                    income: _provider.totalIncome,
                    expense: _provider.totalExpense);
              } else if (index == 1) {
                return _barChartContainer(transactions);
              } else if (index == 2) {
                print('fuck: ${_provider.totalExpensesGroupedByCategory}');
                return _piChartContainer(
                    _provider.totalExpensesGroupedByCategory);
              } else {
                return IncomeExpenseHistoryItem(transactions[index - 3]);
              }
            },
            itemCount: transactions.length + 3,
          );
        }
      },
    );
  }

  Widget _barChartContainer(List<AccountTransactionView> transactions) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setWidth(200),
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.center,
      child: CustomChart(
        transactions,
        isPointChart: false,
      ),
    );
  }

  Widget _piChartContainer(List<TransactionGroupedByCategory> list) {
    return Column(
      children: <Widget>[
        Text(
          Strings.totalExpensesByPercentage,
          style: TextStyle(
              color: ColorRes.blueColor,
              fontSize: ScreenUtil().setSp(DimenRes.normalText)),
        ),
        Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
          height: ScreenUtil().setWidth(200),
          width: ScreenUtil().setWidth(200),
          alignment: Alignment.center,
          child: DonutAutoLabelChart(list),
        ),
      ],
    );
  }
}
