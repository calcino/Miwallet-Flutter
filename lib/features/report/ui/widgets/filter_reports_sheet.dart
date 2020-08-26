import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/features/report/ui/widgets/category_picker_widget.dart';
import 'package:fluttermiwallet/repository/db/entity/category.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';
import '../../../../utils/custom_models/date_range.dart';
import '../../../../utils/custom_models/filter_transactions_model.dart';
import 'choosing_date_sheet.dart';

class FilterReportsSheet extends StatefulWidget {
  FilterTransactionModel filter;
  final Future<List<Category>> categories;

  FilterReportsSheet({@required this.filter, @required this.categories});

  @override
  _FilterReportsSheetState createState() => _FilterReportsSheetState();
}

class _FilterReportsSheetState extends State<FilterReportsSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints(maxHeight: ScreenUtil().setHeight(550)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(30)),
              topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _headerWidget(),
          InkWell(
            child: _item(
                Strings.choosingDate,
                '${DateFormat('yyyy MMM d').format(DateTime.parse(widget.filter.dateRange.from))} '
                '- ${DateFormat('yyyy MMM d').format(DateTime.parse(widget.filter.dateRange.to))}'),
            onTap: _showDateRangePicker,
          ),
          Divider(
            height: 1,
            color: Colors.lightBlueAccent,
          ),
          InkWell(
            child: _item(Strings.category, widget.filter.category?.name),
            onTap: _showCategoryPicker,
          ),
          Divider(
            height: 1,
            color: Colors.lightBlueAccent,
          ),
          _item(Strings.wallets, widget.filter.wallet?.name),
          Divider(
            height: 1,
            color: Colors.lightBlueAccent,
          ),
          Divider(
            height: 1,
            color: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
  }

  void _showCategoryPicker() {
    showModalBottomSheet<Category>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setWidth(30)),
                topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
        builder: (context) {
          return CategoryPickerWidget(widget.categories);
        }).then((value) {
      print('selected Category : $value');
      if (value != null) {
        setState(() {
          widget.filter.category = value;
        });
      }
    });
  }

  void _showDateRangePicker() {
    showModalBottomSheet<DatePeriod>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setWidth(30)),
                topLeft: Radius.circular(ScreenUtil().setWidth(30)))),
        builder: (context) {
          return ChoosingDateSheet(
            selectedPeriod: DatePeriod(
                DateTime.parse(widget.filter.dateRange.from),
                DateTime.parse(widget.filter.dateRange.to)),
          );
        }).then((value) {
      print('selected Date : $value');
      if (value != null) {
        setState(() {
          widget.filter.dateRange = DateRange(
              from: value.start.toIso8601String(),
              to: value.end.toIso8601String());
        });
      }
    });
  }

  Widget _headerWidget() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorRes.blueColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(20)),
              topLeft: Radius.circular(ScreenUtil().setWidth(20)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
            Strings.filters,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(DimenRes.largeText)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, widget.filter);
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

  Widget _item(String title, String value) {
    return Container(
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
            text: title + '  ',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(DimenRes.normalText),
                color: Colors.black54),
            children: [
              TextSpan(
                  text: value ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorRes.blueColor,
                      fontSize: ScreenUtil().setSp(DimenRes.smallText))),
            ]),
      ),
    );
  }
}
