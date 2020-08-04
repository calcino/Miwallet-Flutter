import 'dart:math';

import 'package:charts_common/src/chart/common/behavior/legend/legend.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart' as element;
import 'package:intl/intl.dart';

class CustomBarChart extends StatelessWidget {
  List<charts.Series> seriesList;
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final bool animate;

  CustomBarChart(List<AccountTransactionView> transactionViewList,
      {this.animate = true}) {
    this.seriesList = _createChartSeries(transactionViewList);
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(50)),

      /* domainAxis: charts.DateTimeAxisSpec(
        viewport: charts.DateTimeExtents(
          start: DateTime(data.first.year),
          end: DateTime(data[barsToDisplay - 1].year),
        ),
      ),*/

      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredMinTickCount: 6,
          desiredMaxTickCount: 10,
        ),
      ),
      secondaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
              desiredTickCount: 6, desiredMaxTickCount: 10)),
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection)
            print(model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index));
        })
      ],
      behaviors: [
        charts.SeriesLegend.customLayout(
          CustomLegendBuilder(),
          position: charts.BehaviorPosition.top,
          outsideJustification: charts.OutsideJustification.start,
        ),
      ],
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createChartSeries(
      List<AccountTransactionView> list) {
    List<OrdinalSales> expenseData = [];

    List<OrdinalSales> incomeData = [];

    list.forEach((element) {
      if (element.isIncome) {
        incomeData.add(OrdinalSales(
            DateFormat('MM/dd').format(DateTime.parse(element.dateTime)),
            element.amount));
      } else {
        expenseData.add(OrdinalSales(
            DateFormat('MM/dd').format(DateTime.parse(element.dateTime)),
            element.amount));
      }
    });

    return [
      charts.Series<OrdinalSales, String>(
          id: 'expense',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: expenseData,
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(ColorRes.orangeColor),
          labelAccessorFn: (OrdinalSales sales, _) =>
              'expense: ${sales.sales.toString()}',
          displayName: "Expense"),
      charts.Series<OrdinalSales, String>(
        id: 'income',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: incomeData,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(ColorRes.blueColor),
        displayName: "Income",
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.FillPatternType fillPattern,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: charts.ColorUtil.fromDartColor(Colors.grey[200]));
    var textStyle = style.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(element.TextElement("1", style: textStyle),
        (bounds.left).round(), (bounds.top - 28).round());
  }
}

class CustomLegendBuilder extends charts.LegendContentBuilder {
  @override
  Widget build(BuildContext context, LegendState<dynamic> legendState,
      Legend<dynamic> legend,
      {bool showMeasures}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: legend.chart.currentSeriesList
            .map<Widget>((e) => InkWell(
                  onTap: () {},
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Text(
                        e.displayName,
                        style: TextStyle(color: Colors.white),
                      )),
                ))
            .toList()
              ..add(Spacer())
              ..add(Transform.rotate(
                angle: 90 * (pi / 180),
                child: Icon(
                  Icons.tune,
                  size: 30,
                  //color: Col,
                ),
              )));
  }
}

class OrdinalSales {
  final String year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}
