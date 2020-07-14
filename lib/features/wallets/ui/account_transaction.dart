import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';

class AccountTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(context),
        body: _body(),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        Strings.accountTransactions,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(20),
        ),
      ),
      leading: backButton(context),
      centerTitle: true,
      bottom: bottomTextAppBar(bottomText("Saderat" + Strings.account, size: 14),
          bottomText("150" + Strings.transactions, size: 14),
          marginHorizontal: 26),
    );
  }

  Widget _body() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: index==0?ScreenUtil().setHeight(22):0,
              left: ScreenUtil().setWidth(15.5),
              right: ScreenUtil().setWidth(15.5),
            ),
            child: _accountsField(),
          );
        }
    );
  }

  Widget _accountsField() {
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
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))
      ),
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
                  bottomText("Restaurant", size: 12, color: textColor),
                  bottomText("16:10 , 2020/05/04", size: 9, color: textColor),
                ],
              ),
              space: 8),
          bottomText("-\$150.00", size: 12, color: textColor),
        ],
      ),
    );
  }
}
