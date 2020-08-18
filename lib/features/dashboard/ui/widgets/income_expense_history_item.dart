import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../repository/db/views/account_transaction_view.dart';
import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';
import '../../../../utils/extentions/string_extentions.dart';

class IncomeExpenseHistoryItem extends StatelessWidget {
  final AccountTransactionView _accountTransaction;

  const IncomeExpenseHistoryItem(this._accountTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(50),
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
                _accountTransaction.categoryName,
                style: TextStyle(
                  color: ColorRes.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(DimenRes.smallText),
                ),
              ),
              Text(
                _accountTransaction.subcategoryName,
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
                    '\$' +
                        '${_accountTransaction.amount.toString().split('.')[0].addSeparator()}.'
                            '${_accountTransaction.amount.toString().split('.')[1]}',
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
