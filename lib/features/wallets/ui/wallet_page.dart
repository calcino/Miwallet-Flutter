import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/features/wallets/ui/widgets/account_view_widget.dart';
import 'package:fluttermiwallet/repository/db/entity/account.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/route_name.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  WalletsProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<WalletsProvider>(context,listen: false);
    _provider.getAllAccounts();
  }

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
        Strings.accounts,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(20),
        ),
      ),
      centerTitle: true,
      bottom: bottomTextAppBar(
        bottomText(Strings.totalBalance),
        bottomText("\$6,000.00"),
      ),
    );
  }

  Widget _body() {
    return Selector<WalletsProvider, List<Account>>(
      selector: (ctx, provider) => _provider.accounts,
      builder: (ctx, accounts, child) {
        return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: ScreenUtil().setWidth(21),
                  left: ScreenUtil().setWidth(21),
                  top: index == 0 ? ScreenUtil().setHeight(23) : 0,
                ),
                child: AccountView(account:accounts[index]),
              );
            });
      },
    );
  }
}
