
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class AccountsFieldWidget extends StatelessWidget {
  AccountTransactionView transaction;
  AccountsFieldWidget({Key key,this.transaction}): super(key: key);

  @override
  Widget build(BuildContext context) {
    String transactiontType = transaction.isIncome ? "-" : '+';
    String _date = (transaction.dateTime==null)?"":" "+DateFormat("yyyy/MM/dd").format(DateTime.parse(transaction.dateTime));
    String _time = (transaction.dateTime==null)?"":DateFormat("HH:mm").format(DateTime.parse(transaction.dateTime))+" ,";
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(8),
      ),
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, 3),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          rowWithTwoChild(
              Icon(
                Icons.image,
                size: ScreenUtil().setWidth(31),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  bottomText("subCat", size: 12, color: ColorRes.textColor),
                  bottomText("$_time$_date",
                      size: 9, color: ColorRes.textColor),
                ],
              ),
              space: 8),
          bottomText("$transactiontType\$${transaction.amount}",
              size: 12, color: ColorRes.textColor),
        ],
      ),
    );
  }
}
