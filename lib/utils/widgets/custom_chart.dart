import 'dart:math';

import 'package:charts_common/common.dart' as common;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:flutter/material.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:intl/intl.dart';

import '../../repository/db/views/account_transaction_view.dart';

class CustomChart extends StatelessWidget {
  List<charts.Series<dynamic, String>> _barSeriesList;
  List<charts.Series<dynamic, DateTime>> _pointSeriesList;
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final bool animate;
  final bool isPointChart;
  static String pointerValue;

  CustomChart(List<AccountTransactionView> transactionViewList,
      {this.isPointChart = false, this.animate = true}) {
    _createChartSeries(transactionViewList);
  }

  @override
  Widget build(BuildContext context) {
    return isPointChart ? _pointChart() : _barChart();
  }

  Widget _barChart() {
    return charts.BarChart(
      _barSeriesList,
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
                pointerValue = model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index)
                    .toString();
            })
      ],
      behaviors: [
        charts.LinePointHighlighter(
          symbolRenderer: CustomCircleSymbolRenderer(),
        ),
        charts.SeriesLegend.customLayout(
          CustomLegendBuilder(),
          position: charts.BehaviorPosition.top,
          outsideJustification: charts.OutsideJustification.start,
        ),
      ],
    );
  }

  Widget _pointChart() {
    return charts.TimeSeriesChart(
      _pointSeriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(),
      customSeriesRenderers: [
        new charts.PointRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  List<charts.Series<TransactionModel, DateTime>> _createChartSeries(
      List<AccountTransactionView> list) {
    List<TransactionModel> expenseData = [];

    List<TransactionModel> incomeData = [];

    list.forEach((element) {
      if (element.isIncome) {
        incomeData.add(
            TransactionModel(DateTime.parse(element.dateTime), element.amount));
      } else {
        expenseData.add(
            TransactionModel(DateTime.parse(element.dateTime), element.amount));
      }
    });

    _pointSeriesList = [
      charts.Series<TransactionModel, DateTime>(
          id: 'expense',
          domainFn: (TransactionModel transaction, _) => transaction.date,
          measureFn: (TransactionModel transaction, _) => transaction.amount,
          data: expenseData,
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(ColorRes.orangeColor),
          labelAccessorFn: (TransactionModel transaction, _) =>
              'expense: ${transaction.amount.toString()}',
          displayName: "Expense"),
      charts.Series<TransactionModel, DateTime>(
        id: 'income',
        domainFn: (TransactionModel transaction, _) => transaction.date,
        measureFn: (TransactionModel transaction, _) => transaction.amount,
        data: incomeData,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(ColorRes.blueColor),
        displayName: "Income",
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];

    _barSeriesList = [
      charts.Series<TransactionModel, String>(
          id: 'expense',
          domainFn: (TransactionModel transaction, _) =>
              DateFormat('yy-MM').format(transaction.date),
          measureFn: (TransactionModel transaction, _) => transaction.amount,
          data: expenseData,
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(ColorRes.orangeColor),
          labelAccessorFn: (TransactionModel transaction, _) =>
              'expense: ${transaction.amount.toString()}',
          displayName: "Expense"),
      charts.Series<TransactionModel, String>(
        id: 'income',
        domainFn: (TransactionModel transaction, _) =>
            DateFormat('yy-MM').format(transaction.date),
        measureFn: (TransactionModel transaction, _) => transaction.amount,
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
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: charts.ColorUtil.fromDartColor(Colors.grey[200]));
    var textStyle = style.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 10;

    canvas.drawText(TextElement(CustomChart.pointerValue, style: textStyle),
        (bounds.left).round(), (bounds.top - 25).round());
  }
}

/// Custom legend builder
class CustomLegendBuilder extends charts.LegendContentBuilder {
  /// Convert the charts common TextStlyeSpec into a standard TextStyle.
  TextStyle _convertTextStyle(
      bool isHidden, BuildContext context, charts.TextStyleSpec textStyle) {
    return new TextStyle(
        inherit: true,
        fontFamily: textStyle?.fontFamily,
        fontSize:
        textStyle?.fontSize != null ? textStyle.fontSize.toDouble() : null,
        color: Colors.white);
  }

  Widget createLabel(BuildContext context, common.LegendEntry legendEntry,
      common.SeriesLegend legend, bool isHidden) {
    TextStyle style =
    _convertTextStyle(isHidden, context, legendEntry.textStyle);
    Color color =
        charts.ColorUtil.toDartColor(legendEntry.color) ?? Colors.blue;

    return new GestureDetector(
        child: Container(
            height: 30,
            width: 90,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isHidden ? (color).withOpacity(0.26) : color,
            ),
            child: Center(child: Text(legendEntry.label, style: style))),
        onTapUp: makeTapUpCallback(context, legendEntry, legend));
  }

  GestureTapUpCallback makeTapUpCallback(BuildContext context,
      common.LegendEntry legendEntry, common.SeriesLegend legend) {
    return (TapUpDetails d) {
      switch (legend.legendTapHandling) {
        case common.LegendTapHandling.hide:
          final seriesId = legendEntry.series.id;
          if (legend.isSeriesHidden(seriesId)) {
            // This will not be recomended since it suposed to be accessible only from inside the legend class, but it worked fine on my code.
            legend.showSeries(seriesId);
          } else {
            legend.hideSeries(seriesId);
          }
          legend.chart.redraw(skipLayout: true, skipAnimation: false);
          break;
        case common.LegendTapHandling.none:
        default:
          break;
      }
    };
  }

  @override
  Widget build(BuildContext context, common.LegendState legendState,
      common.Legend legend,
      {bool showMeasures}) {
    final entryWidgets = legendState.legendEntries.map((legendEntry) {
      var isHidden = false;
      if (legend is common.SeriesLegend) {
        isHidden = legend.isSeriesHidden(legendEntry.series.id);
      }
      return createLabel(
          context, legendEntry, legend as common.SeriesLegend, isHidden);
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(right: 40.0, top: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: entryWidgets),
    );
  }
}


class TransactionModel {
  final DateTime date;
  final double amount;

  TransactionModel(this.date, this.amount);
}
