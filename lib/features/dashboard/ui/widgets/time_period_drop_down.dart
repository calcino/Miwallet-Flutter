import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';
import '../../../../utils/custom_models/date_range.dart';

class TimePeriodDropDown extends StatefulWidget {
  final Function(DateRange) onSelectDate;

  const TimePeriodDropDown({Key key, this.onSelectDate}) : super(key: key);

  @override
  _TimePeriodDropDownState createState() => _TimePeriodDropDownState();
}

class _TimePeriodDropDownState extends State<TimePeriodDropDown> {
  String _selectedRange = Strings.dashboardRangeOfDate[0];

  @override
  Widget build(BuildContext context) {
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
            onChanged: _onSelectedDateRange,
          ),
        ),
      ),
    );
  }

  void _onSelectedDateRange(String value) {
    String toDate = DateTime.now().toIso8601String();
    String fromDate =
        DateTime.now().subtract(Duration(days: 730)).toIso8601String();
    if (Strings.dashboardRangeOfDate[0] == value) {
      fromDate = DateTime.now().subtract(Duration(days: 7)).toIso8601String();
    } else if (Strings.dashboardRangeOfDate[1] == value) {
      fromDate = DateTime.now().subtract(Duration(days: 30)).toIso8601String();
    } else if (Strings.dashboardRangeOfDate[2] == value) {
      fromDate = DateTime.now().subtract(Duration(days: 365)).toIso8601String();
    } else {
      fromDate = DateTime.now().subtract(Duration(days: 730)).toIso8601String();
    }

    if (_selectedRange != value) {
      widget.onSelectDate(DateRange(from: fromDate, to: toDate));
      setState(() {
        _selectedRange = value;
      });
    }
  }
}
