import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/features/wallets/ui/widgets/accounts_field_widget.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class AccountTransactionPage extends StatefulWidget {
  int _id;

  AccountTransactionPage(this._id);

  @override
  _AccountTransactionPageState createState() => _AccountTransactionPageState();
}

class _AccountTransactionPageState extends State<AccountTransactionPage> {
  WalletsProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<WalletsProvider>(context);
    _provider.getAllTransaction();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(context),
        body: ChangeNotifierProvider(
            create: (_) => Provider.of<WalletsProvider>(context, listen: false),
            builder: (context, _) {
              return _body();
            }),
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
      bottom: bottomTextAppBar(
          bottomText("Saderat" + Strings.account, size: 14),
          bottomText("150" + Strings.transactions, size: 14),
          marginHorizontal: 26),
    );
  }

  Widget _body() {
    return Selector<WalletsProvider, List<AccountTransactionView>>(
        selector: (ctx, provider) => _provider.transactions,
        builder: (ctx, transaction, child) {
          return ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                _provider.findSubCategory(transaction[index].subcategoryId);
                var name = _provider.subcategoryName;
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? ScreenUtil().setHeight(22) : 0,
                    left: ScreenUtil().setWidth(15.5),
                    right: ScreenUtil().setWidth(15.5),
                  ),
                  child: AccountsFieldWidget(transaction:transaction[index]),
                );
              });
        });
  }

}
