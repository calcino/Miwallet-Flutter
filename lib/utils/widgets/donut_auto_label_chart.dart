
import 'dart:math';

// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fluttermiwallet/repository/db/views/transaction_grouped_by_category.dart';

class DonutAutoLabelChart extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(List<TransactionGroupedByCategory> transactions,
      {this.animate = true}) {
    this.seriesList = _convertTransactionsToSeries(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(
            strokeWidthPx: 0,
            arcWidth: 40,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.auto)
            ]));
  }

  static List<charts.Series<TransactionGroupedByCategory, int>>
      _convertTransactionsToSeries(
          List<TransactionGroupedByCategory> transactions) {
    double totalAmount = 0.0;
    transactions.forEach((element) {
      totalAmount += element.amountSum;
    });

    return [
      new charts.Series<TransactionGroupedByCategory, int>(
        id: 'Transactions',
        domainFn: (TransactionGroupedByCategory history, _) =>
            history.categoryId,
        measureFn: (TransactionGroupedByCategory history, _) =>
            history.amountSum,
        colorFn: (TransactionGroupedByCategory history, _) =>
            charts.Color.fromHex(code: history.categoryHexColor),
        data: transactions,
        labelAccessorFn: (TransactionGroupedByCategory history, _) =>
            ((history.amountSum / totalAmount) * 100).toStringAsFixed(1)+'%',
      )
    ];
  }
}
