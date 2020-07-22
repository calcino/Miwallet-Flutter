import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/features/dashboard/logic/dashboard_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/custom_paint/custom_rock_painter.dart';
import 'package:fluttermiwallet/utils/extentions/string_extentions.dart';
import 'package:fluttermiwallet/utils/logger/logger.dart';
import 'package:fluttermiwallet/utils/widgets/auto_label.dart';
import 'package:fluttermiwallet/utils/widgets/series_legend_options.dart';
import 'package:fluttermiwallet/utils/widgets/total_income_expnse.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedRange = Strings.dashboardRangeOfDate[0];

  DashboardProvider _provider;

  @override
  void initState() {
    super.initState();
    var appProvider = context.read<AppProvider>();
    _provider = DashboardProvider(appProvider.db);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    //_provider.insertFakeCategory();
    //_provider.insertFakeSubcategory();
    //_provider.insertFakeBank();
    //_provider.insertFakeAccount();
    //_provider.insertFakeTransfer();
    //_provider.insertFakeAccountTransactions();

    //_provider.getCategories();
    //_provider.getSubcategories();
    //_provider.getAllAccounts();
    //_provider.getAllBanks();
    _provider.getAccountTransactions();
    //_provider.getTransfers();
    //_provider.getTransactionView();

    Logger.log('dashboard build called: ${DateTime.now().toIso8601String()}');
    return ChangeNotifierProvider<DashboardProvider>(
      create: (_) => _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appbar(),
        body: _body(),
      ),
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
      bottom: _totalBalanceWidget(),
    );
  }

  Widget _totalBalanceWidget() {
    return PreferredSize(
        preferredSize: Size(double.infinity, ScreenUtil().setHeight(70)),
        child: Padding(
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
                  _dateRangeWidget(),
                ],
              ),
              Consumer<DashboardProvider>(
                builder: (ctx, provider, child) {
                  Logger.log('total balance consumer');
                  var totalBalance =
                      provider.totalBalance.toString().split('.');
                  return Text(
                    '\$${totalBalance[0].addSeparator()}.${totalBalance[1]}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(DimenRes.largeText),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget _dateRangeWidget() {
    return DropdownButtonHideUnderline(
      child: Container(
        height: ScreenUtil().setWidth(25),
        decoration: BoxDecoration(
            color: ColorRes.blueColor,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(
                ScreenUtil().setWidth(25),
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1)
            ]),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
              value: _selectedRange,
              elevation: 8,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(DimenRes.smallText)),
              items: Strings.dashboardRangeOfDate
                  .map(
                    (String value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                setState(() {
                  _selectedRange = v;
                });
              }),
        ),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Selector<DashboardProvider, bool>(
        selector: (_, provider) => provider.isLoading,
        builder: (_, isLoading, ___) =>
            isLoading ? CircularProgressIndicator() : _transactionList(),
      ),
    );
  }

  Widget _transactionList() {
    return Selector<DashboardProvider, List<AccountTransactionView>>(
      selector: (ctx, provider) => provider.transactions,
      builder: (ctx,List<AccountTransactionView> transactions, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>()
              ..add(TotalIncomeExpense(
                income: _provider.totalIncome,
                expense: _provider.totalExpense,
              ))
              ..add(transactions.isEmpty
                  ? Container()
                  : _chartContainer(transactions))
              ..add(transactions.isEmpty ? _emptyWidget() : _piChartContainer())
              ..addAll(transactions.map<Widget>(
                  (AccountTransactionView transaction) =>
                      _IncomeExpensePercentHistory(transaction))),
          ),
        );
      },
    );
  }

  Widget _chartContainer(List<AccountTransactionView> transactions) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setWidth(200),
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.center,
      child: LegendOptions(transactions),
    );
  }

  Widget _piChartContainer() {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setWidth(120),
      width: ScreenUtil().setWidth(120),
      alignment: Alignment.center,
      child: DonutAutoLabelChart.withSampleData(),
    );
  }

  Widget _emptyWidget() {
    Widget _rockWidget() {
      return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenUtil().setHeight(300),
            width: double.infinity,
            child: CustomPaint(
              painter: CustomRockPainter(),
            ),
          ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          Strings.emptyData,
          style: TextStyle(
              color: ColorRes.blueColor,
              fontSize: ScreenUtil().setSp(DimenRes.largeText)),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        _rockWidget(),
      ],
    );
  }
}

class _IncomeExpensePercentHistory extends StatelessWidget {
  final AccountTransactionView _accountTransaction;

  const _IncomeExpensePercentHistory(this._accountTransaction);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 360);
    return Container(
      height: ScreenUtil().setHeight(30),
      margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(5))),
          boxShadow: [
            BoxShadow(color: Colors.grey[300], spreadRadius: 0, blurRadius: 7)
          ]),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.image,
            size: ScreenUtil().setWidth(30),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(7),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _accountTransaction.categoryName,
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(DimenRes.smallText),
                ),
              ),
              Text(
                _accountTransaction.subcategoryName,
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontSize: ScreenUtil().setSp(DimenRes.smallText),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '9%',
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(DimenRes.smallText),
                ),
              ),
              Container(
                constraints:
                    BoxConstraints(maxWidth: ScreenUtil().setWidth(70)),
                child: FittedBox(
                  child: Text(
                    '\$' +
                        '${_accountTransaction.amount.toString().split('.')[0].addSeparator()}.'
                            '${_accountTransaction.amount.toString().split('.')[1]}',
                    style: TextStyle(
                      color: ColorRes.blueColor,
                      fontSize: ScreenUtil().setSp(DimenRes.smallText),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
