import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        accounts,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(20),
        ),
      ),
      centerTitle: true,
      bottom: bottomTextAppBar(
        bottomText(totalBalance),
        bottomText("\$6,000.00"),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(21),),
            child: AccountView(),
          );
        });
  }
}

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
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
          color: boxColor,
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
            _accountOperaterView(),
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
        color: boxColor,
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
            bottomText("Accounts Name", size: 12, color: textColor),
          ),
          rowWithTwoChild(
            bottomText("\$1500.00", size: 12, color: textColor),
            Transform.rotate(
              angle: _rotateAnim.value,
              child: Icon(
                Icons.arrow_drop_down,
                size: ScreenUtil().setWidth(31),
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountOperaterView() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isExpanded ? ScreenUtil().setHeight(50) : 0,
        ),
        Divider(
          height: ScreenUtil().setHeight(1),
          color: blueColor.withOpacity(0.17),
        ),
        Container(
          height: ScreenUtil().setHeight(49),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              operatorContainer(moneyTransfer),
              VerticalDivider(
                color: blueColor.withOpacity(0.17),
                width: ScreenUtil().setHeight(1),
                indent: ScreenUtil().setHeight(1),
                endIndent: ScreenUtil().setHeight(1),
              ),
              operatorContainer(transactions),
              VerticalDivider(
                color: blueColor.withOpacity(0.17),
                width: ScreenUtil().setHeight(1),
                indent: ScreenUtil().setHeight(1),
                endIndent: ScreenUtil().setHeight(1),
              ),
              operatorContainer(edit),
            ],
          ),
        ),
      ],
    );
  }

  Widget operatorContainer(String text) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: bottomText(text, size: 12, color: textColor),
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
