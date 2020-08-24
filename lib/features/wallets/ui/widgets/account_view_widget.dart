
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/repository/db/entity/account.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/route_name.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
  Account account;

  AccountView({Key key,this.account}): super(key: key);
}

class _AccountViewState extends State<AccountView>
    with SingleTickerProviderStateMixin {
  var isExpanded = false;
  AnimationController _controller;
  Animation<double> _rotateAnim;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _rotateAnim = Tween<double>(begin: 0.0, end: pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _switchExpandedMode();
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(12),
        ),
        decoration: BoxDecoration(
          color: ColorRes.boxColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, 3),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(10),
          ),
        ),
        child: Stack(
          children: <Widget>[
            _accountOperatorView(),
            _accountView(),
          ],
        ),
      ),
    );
  }

  Widget _accountView() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
        color: ColorRes.boxColor,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          rowWithTwoChild(
            Icon(
              Icons.image,
              size: ScreenUtil().setWidth(31),
            ),
            bottomText(widget.account.name,
                size: 12, color: ColorRes.textColor),
          ),
          rowWithTwoChild(
            bottomText("\$" + widget.account.balance.toString(),
                size: 12, color: ColorRes.textColor),
            Transform.rotate(
              angle: _rotateAnim.value,
              child: Icon(
                Icons.arrow_drop_down,
                size: ScreenUtil().setWidth(31),
                color: ColorRes.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountOperatorView() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isExpanded ? ScreenUtil().setHeight(50) : 0,
        ),
        Divider(
          height: ScreenUtil().setHeight(1),
          color: ColorRes.blueColor.withOpacity(0.17),
        ),
        Container(
          height: ScreenUtil().setHeight(49),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              operatorContainer(
                Strings.moneyTransfer,
                onTap: () => Navigator.pushNamed(
                    context, RouteName.moneyTransferPage,
                    arguments: widget.account.id),
              ),
              VerticalDivider(
                color: ColorRes.blueColor.withOpacity(0.17),
                width: ScreenUtil().setHeight(1),
                indent: ScreenUtil().setHeight(1),
                endIndent: ScreenUtil().setHeight(1),
              ),
              operatorContainer(
                Strings.transactions,
                onTap: () => Navigator.pushNamed(
                    context, RouteName.accountTransactionsPage,
                    arguments: widget.account.id),
              ),
              VerticalDivider(
                color: ColorRes.blueColor.withOpacity(0.17),
                width: ScreenUtil().setHeight(1),
                indent: ScreenUtil().setHeight(1),
                endIndent: ScreenUtil().setHeight(1),
              ),
              operatorContainer(
                Strings.edit,
                onTap: () => Navigator.pushNamed(context, RouteName.walletPage,
                    arguments: widget.account.id),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget operatorContainer(String text, {onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: bottomText(text, size: 12, color: ColorRes.textColor),
        ),
      ),
    );
  }

  void _switchExpandedMode() {
    if (isExpanded == false) {
      setState(() {
        isExpanded = true;
      });
      _controller.forward();
    } else {
      setState(() {
        isExpanded = false;
      });
      _controller.reverse();
    }
  }
}
