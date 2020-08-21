import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../../res/colors.dart';
import '../../res/strings.dart';
import '../../utils/extentions/string_extentions.dart';
import '../../utils/income_expense.dart';

class TotalIncomeExpense extends StatelessWidget {
  final IncomeExpense incomeExpense;

  const TotalIncomeExpense({Key key, @required this.incomeExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        height: ScreenUtil().setHeight(80),
        margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(20),
            left: ScreenUtil().setWidth(15),
            right: ScreenUtil().setWidth(15),
            bottom: ScreenUtil().setWidth(0)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                ScreenUtil().setWidth(6),
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], offset: Offset(0, 2), blurRadius: 7)
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _globalCostWidget(isIncome: true, amount: incomeExpense.income),
            _divider(),
            _globalCostWidget(isIncome: false, amount: incomeExpense.expense),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return VerticalDivider(
      color: Colors.grey[300],
      thickness: 1,
      width: 2,
    );
  }

  Widget _globalCostWidget({bool isIncome = true, double amount = 0.0}) {
    IconData _iconData = isIncome ? Icons.arrow_downward : Icons.arrow_upward;
    Color _arrowColor = isIncome ? ColorRes.blueColor : ColorRes.orangeColor;
    Color _backColor = _arrowColor.withOpacity(0.2);
    Color _amountColor = isIncome ? ColorRes.greenColor : ColorRes.redColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setWidth(40),
          decoration: BoxDecoration(
            color: _backColor,
            borderRadius: BorderRadius.all(
              Radius.circular(ScreenUtil().setWidth(6)),
            ),
          ),
          child: Icon(
            _iconData,
            color: _arrowColor,
            size: ScreenUtil().setWidth(20),
          ),
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
              isIncome ? Strings.income : Strings.expense,
              style: TextStyle(
                color: ColorRes.blueColor,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(7),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(70)),
              child: FittedBox(
                child: Text(
                  '\$' +
                      '${amount.toString().split('.')[0].addSeparator()}' +
                      '.' +
                      '${amount.toStringAsFixed(2).split('.')[1]}',
                  style: TextStyle(color: _amountColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
