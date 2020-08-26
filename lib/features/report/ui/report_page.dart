import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../repository/db/views/account_transaction_view.dart';
import '../../../res/colors.dart';
import '../../../res/strings.dart';
import '../../../utils/custom_models/filter_transactions_model.dart';
import '../../../utils/custom_models/income_expense.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/widgets/custom_chart.dart';
import '../../../utils/widgets/loading_widget.dart';
import '../../../utils/widgets/total_income_expense.dart';
import '../logic/report_provider.dart';
import 'report_export_popup.dart';
import 'widgets/filter_reports_sheet.dart';
import 'widgets/report_app_bar.dart';
import 'widgets/report_row_item.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ReportProvider _provider;
  FilterTransactionModel _filterTransactionModel;

  @override
  void initState() {
    super.initState();
    _filterTransactionModel = FilterTransactionModel();
    _provider = Provider.of<ReportProvider>(context, listen: false);
    _provider.getAccountTransactions(_filterTransactionModel);
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _body(),
      floatingActionButton: _exportFAB(),
      appBar: ReportAppBar(
        filterTransactionModel: _filterTransactionModel,
        callback: _openFilterReportBottomSheet,
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [_content(), _loadingWidget()],
      ),
    );
  }

  Widget _loadingWidget() {
    return Selector<ReportProvider, bool>(
        selector: (_, provider) => provider.isLoading,
        builder: (_, isLoading, __) =>
        isLoading ? LoadingWidget() : Container());
  }

  Widget _incomeExpenseWidget() {
    return Selector<ReportProvider, IncomeExpense>(
        builder: (_, incomeExpense, ___) =>
            TotalIncomeExpense(incomeExpense: incomeExpense),
        selector: (_, provider) => provider.incomeExpense);
  }

  Widget _customChartWidget() {
    return Selector<ReportProvider, List<AccountTransactionView>>(
      selector: (_, provider) => provider.transactionHistory,
      builder: (_, transactions, __) =>
          CustomChart(
            transactions,
            isPointChart: true,
          ),
    );
  }

  Widget _content() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _incomeExpenseWidget(),
          Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
              height: ScreenUtil().setWidth(200),
              width: ScreenUtil().setWidth(300),
              color: Colors.white,
              alignment: Alignment.center,
              child: _customChartWidget()),
          _averageCostPerDayWidget(),
          _numberOfTransactionWidget(),
        ],
      ),
    );
  }

  Widget _averageCostPerDayWidget() {
    return Selector<ReportProvider, double>(
      selector: (_, provider) => provider.averageCostPerDay,
      builder: (_, averageCostPerDay, __) =>
          ReportRowItem(
              backgroundColor: Colors.grey[200],
              title: Strings.averageCostPerDay,
              value: '\$$averageCostPerDay'),
    );
  }

  Widget _numberOfTransactionWidget() {
    return Selector<ReportProvider, int>(
      selector: (_, provider) => provider.numberOfTransactions,
      builder: (_, numberOfTransactions, __) =>
          ReportRowItem(
              backgroundColor: Colors.white,
              title: Strings.numberOfTransaction,
              value: '$numberOfTransactions'),
    );
  }

  Widget _exportFAB() {
    return FloatingActionButton(
      onPressed: _showExportPopup,
      backgroundColor: ColorRes.orangeColor,
      child: Icon(
        Icons.file_upload,
        color: Colors.white,
      ),
    );
  }

  _showExportPopup() {
    showDialog(
        context: context,
        child: ReportExportPopup(
          onExportClicked: _exportReports,
        ));
  }

  _exportReports(String fileName) {
    //todo export reports here
  }

  _openFilterReportBottomSheet() {
    showModalBottomSheet<FilterTransactionModel>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setWidth(30)),
                topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
        builder: (context) {
          return FilterReportsSheet(filter: _filterTransactionModel,
            categories: _provider.getCategories(),);
        }).then((value) {
      if (value != null) {
        Logger.log('filter updated : $value');
        setState(() {
          _filterTransactionModel = value;
        });
        _provider.getAccountTransactions(_filterTransactionModel);
      }
    });
  }
}
