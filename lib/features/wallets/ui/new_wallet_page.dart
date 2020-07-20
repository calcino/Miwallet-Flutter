import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/error_widget.dart';
import 'package:provider/provider.dart';

class AddWalletPage extends StatefulWidget {
  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  bool _isSaving = true;
  bool _isShowing = true;
  WalletsProvider _provider;
  bool _isAccountSelected = false;
  bool _isBankSelected = false;
  int accId;
  int bankId;
  String _accountNameSelected = Strings.choose;
  String _accountBankSelected = Strings.choose;
  double _amount;
  String _description;
  bool _isChoosedAccount = false;
  bool _isChoosedBank = false;

  @override
  void initState() {
    var appProvider = context.read<AppProvider>();
    _provider = WalletsProvider(appProvider.db);
    super.initState();
  }

  _isEmptyField() {
    if (_accountNameSelected == Strings.choose) {
      _isChoosedAccount = true;
    }
    if (_accountNameSelected == Strings.choose) {
      _isChoosedBank = true;
    } else {
      _isChoosedAccount = false;
      _isChoosedBank = false;
      _provider.updateAccount(
        Account(
          bankId: bankId,
          name: _accountNameSelected,
          balance: _amount,
          descriptions: _description,
          createdDateTime: DateTime.now().toIso8601String(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
          context,
          bottomCalcAppBar(onSubmitted: (amount) => _amount = amount),
          Strings.newWallets,
          saveOnTap: () {
            setState(() {
              _isEmptyField();
            });
          },
        ),
        body: ChangeNotifierProvider(
            create: (_) => WalletsProvider(
                Provider.of<AppProvider>(context, listen: false).db),
            builder: (context, _) {
              return _body();
            }),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          errorTextWidget(_isChoosedAccount, Strings.pleaseChooseAccount),
          customTextBox(
            marginTop: 19,
            label: Strings.accountName,
            childWidget: chooseBottomSheet(_accountNameSelected),
            onPressed: () {
              setState(() {
                _isChoosedAccount =false;
              });
              showModalBottomSheetWidget(
                context,
                ChangeNotifierProvider.value(
                  value: _provider,
                  child: _chooseBtmSheet(context, Strings.accountName, true,
                      (account) {
                    setState(
                      () {
                        _isAccountSelected = true;
                        _accountNameSelected = account.name;
                        accId = account.sourceId;
                      },
                    );
                  }),
                ),
              );
            },
          ),
          errorTextWidget(_isChoosedBank, Strings.pleaseChooseBank),
          customTextBox(
            marginTop: 10,
            label: Strings.bank,
            childWidget: chooseBottomSheet(_accountBankSelected),
            onPressed: () {
              setState(() {
                _isChoosedBank= false;
              });
              showModalBottomSheetWidget(
                context,
                ChangeNotifierProvider.value(
                  value: _provider,
                  child: _chooseBtmSheet(context, Strings.bank, false, (bank) {
                    setState(() {
                      _isBankSelected = true;
                      _accountBankSelected = bank.name;
                      bankId = bank.sourceId;
                    });
                  }),
                ),
              );
            },
          ),
          customTextBox(
            marginTop: 10,
            label: Strings.description,
            marginBottom: 0,
            height: 84,
            childWidget: descTextField((text) => _description = text),
          ),
          switchBoxRow(Strings.savingsAccount, _isSaving,
              onChanged: (bool) => setState(() {
                    _isSaving = !_isSaving;
                  })),
          switchBoxRow(Strings.showInTotalBalance, _isShowing,
              onChanged: (bool) => setState(() {
                    _isShowing = !_isShowing;
                  })),
        ],
      ),
    );
  }

  Widget _chooseBtmSheet(
    BuildContext context,
    String title,
    bool isAccount,
    Function(dynamic) onTap,
  ) {
    isAccount ? _provider.getAllAccounts() : _provider.findAllBank();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(title, context, isBackable: false),
          Selector<WalletsProvider, List<dynamic>>(
              selector: (ctx, provider) =>
                  isAccount ? provider.accounts : provider.banks,
              builder: (_, data, __) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              onTap(data[index]);
                              Navigator.pop(context);
                            },
                            child: categoryListField(data[index].name),
                          ),
                          Divider(
                            color: ColorRes.hintColor,
                            height: ScreenUtil().setHeight(1),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget switchBoxRow(String text, bool value, {Function onChanged}) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(27),
        left: ScreenUtil().setWidth(37),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), color: ColorRes.blueColor),
          ),
          CupertinoSwitch(
            activeColor: ColorRes.blueColor,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
