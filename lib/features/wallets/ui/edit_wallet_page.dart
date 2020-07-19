import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EditWalletPage extends StatefulWidget {
  @override
  _EditWalletPageState createState() => _EditWalletPageState();
}

class _EditWalletPageState extends State<EditWalletPage> {
  bool _isSaving = true;
  bool _isShowing = true;
  WalletsProvider _provider;
  bool _isAccountSelected = false;
  bool _isBankSelected = false;
  String _accountNameSelected = Strings.choose;
  String _accountBankSelected = Strings.choose;
  double _amount;
  String _description;

  @override
  void initState() {
    _provider = Provider.of<WalletsProvider>(context, listen: false);
//    _provider.insertFakeBank();
    _provider.findAllBank();
    _provider.getAllAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, bottomCalcAppBar(onSubmitted: (amount)=>_amount=amount), Strings.editWallet,
            saveOnTap: () => _provider.updateAccount(Account(
                bankId: null,
                name: _accountNameSelected,
                balance: _amount,
                descriptions: _description,
                createdDateTime: null))),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Selector<WalletsProvider, List<Account>>(
            selector: (ctx, provider) => _provider.accounts,
            builder: (ctx, accounts, child) {
              return customTextBox(
                marginTop: 19,
                label: Strings.accountName,
                childWidget: chooseBottomSheet(_accountNameSelected),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          ScreenUtil().setWidth(25),
                        ),
                      ),
                    ),
                    context: ctx,
                    isScrollControlled: true,
                    builder: (contxt) {
                      return StatefulBuilder(
                        builder: (BuildContext contextz, StateSetter setState) {
                          return _chooseBtmSheet(ctx, accounts, (name) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                _isAccountSelected = true;
                                _accountNameSelected =name;
                                Navigator.of(context).pop(ctx);

                              },

                            );
                          });
                        }
                      );
                    },
                  );
                },
              );
            },
          ),
          Selector<WalletsProvider, List<Bank>>(
            selector: (ctx, provider) => _provider.banks,
            builder: (ctx, banks, child) {
              return customTextBox(
                marginTop: 10,
                label: Strings.bank,
                childWidget: chooseBottomSheet(_accountBankSelected),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          ScreenUtil().setWidth(25),
                        ),
                      ),
                    ),
                    context: ctx,
                    isScrollControlled: true,
                    builder: (contxt) {
                      return _chooseBtmSheet(ctx, banks,(name){
                        setState(() {
                          _isBankSelected = true;
                          _accountBankSelected = name;
                        });
                      });
                    },
                  );
                },
              );
            },
          ),
          customTextBox(
            marginTop: 10,
            label: Strings.description,
            marginBottom: 0,
            height: 84,
            childWidget: descTextField((text)=>_description = text),
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
      BuildContext context, var banks, Function(String) onTap) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.selectBank, context,isBackable: false),
          Expanded(
            child: ListView.builder(
              itemCount: banks.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: onTap(banks[index].name),
                      child: categoryListField(banks[index].name),
                    ),
                    Divider(
                      color: ColorRes.hintColor,
                      height: ScreenUtil().setHeight(1),
                    ),
                  ],
                );
              },
            ),
          ),
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
            style:
                TextStyle(fontSize: ScreenUtil().setSp(14), color: ColorRes.blueColor),
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
