import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../repository/db/views/account_transaction_view.dart';
import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';
import '../../../../utils/extentions/color_extentions.dart';
import '../../../../utils/extentions/string_extentions.dart';

class HistoryItemWidget extends StatelessWidget {
  final AccountTransactionView accountTransaction;
  final bool isLastItem;

  const HistoryItemWidget(
      {Key key, @required this.accountTransaction, this.isLastItem = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(15),
          right: ScreenUtil().setWidth(15),
          bottom: isLastItem ? ScreenUtil().setWidth(12) : 0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[350], offset: Offset(0, 3), blurRadius: 4)
      ]),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.image,
            size: ScreenUtil().setWidth(35),
            color: ColorExtentions.fromHex(
                code: accountTransaction.categoryHexColor),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(7),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${accountTransaction.categoryName}',
                style: TextStyle(
                    color: ColorRes.blueColor,
                    fontSize: ScreenUtil().setSp(DimenRes.smallText)),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Text(
                '${accountTransaction.subcategoryName}',
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontSize: ScreenUtil().setSp(DimenRes.verySmallText),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                constraints:
                    BoxConstraints(maxWidth: ScreenUtil().setWidth(70)),
                child: FittedBox(
                  child: Text(
                    '\$' +
                        '${accountTransaction.amount.toString().split('.')[0].addSeparator()}' +
                        '.' +
                        '${accountTransaction.amount.toString().split('.')[1]}',
                    style: TextStyle(
                        color: accountTransaction.isIncome
                            ? ColorRes.greenColor
                            : ColorRes.redColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(7),
              ),
              Text(
                '${DateFormat('HH:mm').format(DateTime.parse(accountTransaction.dateTime))}',
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontSize: ScreenUtil().setSp(DimenRes.verySmallText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
