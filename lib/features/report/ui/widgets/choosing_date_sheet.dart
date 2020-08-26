import 'package:flutter/material.dart' hide DayPicker;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';

class ChoosingDateSheet extends StatefulWidget {
  DatePeriod selectedPeriod;

  ChoosingDateSheet({Key key, this.selectedPeriod}) : super(key: key) {
    DateTime _selectedPeriodStart = DateTime.now().subtract(Duration(days: 4));
    DateTime _selectedPeriodEnd = DateTime.now().add(Duration(days: 8));
    selectedPeriod ??= DatePeriod(_selectedPeriodStart, _selectedPeriodEnd);
  }

  @override
  State<StatefulWidget> createState() => _ChoosingDateSheetState();
}

class _ChoosingDateSheetState extends State<ChoosingDateSheet> {
  DateTime _firstDate;
  DateTime _lastDate;
  String selectedDate = '';

  Color selectedPeriodStartColor;
  Color selectedPeriodLastColor;
  Color selectedPeriodMiddleColor;

  @override
  void initState() {
    super.initState();
    _firstDate = DateTime.now().subtract(Duration(days: 45));
    _lastDate = DateTime.now().add(Duration(days: 45));
    selectedDate =
        '${DateFormat('MMM d').format(widget.selectedPeriod.start)} - ${DateFormat('MMM d').format(widget.selectedPeriod.end)}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedPeriodLastColor = ColorRes.orangeColor;
    selectedPeriodMiddleColor = ColorRes.orangeColor;
    selectedPeriodStartColor = ColorRes.orangeColor;
  }

  Widget _headerWidget() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.center,
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
          color: ColorRes.blueColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(20)),
              topLeft: Radius.circular(ScreenUtil().setWidth(20)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            selectedDate ??= '',
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(DimenRes.normalText)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, widget.selectedPeriod);
            },
            child: Text(
              Strings.save,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(DimenRes.normalText)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setWidth(20)),
                topLeft: Radius.circular(ScreenUtil().setWidth(20)))),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _headerWidget(),
          _rangePicker(),
        ]));
  }

  Widget _rangePicker() {
    // add selected colors to default settings
    DatePickerRangeStyles styles = DatePickerRangeStyles(
        selectedPeriodLastDecoration: BoxDecoration(
            color: selectedPeriodLastColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0))),
        selectedPeriodStartDecoration: BoxDecoration(
          color: selectedPeriodStartColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100.0),
              bottomLeft: Radius.circular(100.0)),
        ),
        selectedPeriodMiddleDecoration: BoxDecoration(
            color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
        nextIcon: const Icon(Icons.arrow_right),
        prevIcon: const Icon(Icons.arrow_left),
        dayHeaderStyleBuilder: _dayHeaderStyleBuilder);

    return RangePicker(
      selectedPeriod: widget.selectedPeriod,
      onChanged: _onSelectedDateChanged,
      firstDate: _firstDate,
      lastDate: _lastDate,
      datePickerStyles: styles,
      selectableDayPredicate: _isSelectableCustom,
    );
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      widget.selectedPeriod = newPeriod;
      selectedDate =
          '${DateFormat('MMM d').format(newPeriod.start)} - ${DateFormat('MMM d').format(newPeriod.end)}';
    });
  }

  bool _isSelectableCustom(DateTime day) {
    return true;
//    return day.weekday < 6;
//    return day.day != DateTime.now().add(Duration(days: 7)).day ;
  }

  // 0 is Sunday, 6 is Saturday
  DayHeaderStyle _dayHeaderStyleBuilder(int weekday) {
    bool isWeekend = weekday == 0 || weekday == 6;

    return DayHeaderStyle(
        textStyle: TextStyle(color: isWeekend ? Colors.red : Colors.teal));
  }
}
