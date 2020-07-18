import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
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

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _selectedRange = Strings.dashboardRangeOfDate[0];

  DashboardProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<DashboardProvider>();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    //_provider.insertFakeSubcategory();
    //_provider.insertFakeCategory();
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

    Logger.log('dashboard build called: ${DateTime.now().toIso8601String()}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _provider.changeData();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _appbar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        Strings.dashboard,
        style: TextStyle(
            color: Colors.white, fontSize: ScreenUtil().setSp(DimenRes.largeText)),
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
                  color: Colors.white, fontSize: ScreenUtil().setSp(DimenRes.smallText)),
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
    return Selector<DashboardProvider, List<AccountTransaction>>(
      selector: (ctx, provider) => provider.transactions,
      builder: (ctx, transactions, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>()
              ..add(_totalIncomeExpense())
              ..add(transactions.isEmpty ? Container() : _chartContainer())
              ..add(transactions.isEmpty ? _emptyWidget() : _piChartContainer())
              ..addAll(transactions.map<Widget>(
                  (AccountTransaction transaction) =>
                      _IncomeExpensePercentHistory(transaction))),
          ),
        );
      },
    );
  }

  Widget _totalIncomeExpense() {
    return Selector<DashboardProvider, double>(
      selector: (ctx, a) => _provider.totalIncome,
      builder: (ctx, income, child) {
        Logger.log('consumer TotalIncomeExpense');
        return TotalIncomeExpense(
          income: income,
          expense: _provider.totalExpense,
        );
      },
    );
  }

  Widget _chartContainer() {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setWidth(200),
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.center,
      child: LegendOptions.withSampleData(),
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
              color: ColorRes.blueColor, fontSize: ScreenUtil().setSp(DimenRes.largeText)),
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
  final AccountTransaction _accountTransaction;

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
                'title',
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(DimenRes.smallText),
                ),
              ),
              Text(
                'subtitle',
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
                    '\$' + '${20038374.toString().addSeparator()}',
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
