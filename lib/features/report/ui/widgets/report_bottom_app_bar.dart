import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';

class ReportBottomAppBar extends StatelessWidget {
  final String selectedDate;
  final List<String> filtered;

  const ReportBottomAppBar({Key key, this.selectedDate, this.filtered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                Strings.byChoosingDate,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(DimenRes.normalText),
                    color: Colors.white),
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () {
                  //todo handle on tap
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      selectedDate ?? '',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(DimenRes.verySmallText),
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: ScreenUtil().setWidth(20),
                    ),
                  ],
                ),
              )
            ],
          ),
          Text(
            'Filtered: ${filtered.join(' ').toString()}',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(DimenRes.smallText),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
