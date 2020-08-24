import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/features/wallets/ui/widgets/choose_wallet_bottom_sheet_widget.dart';
import 'package:fluttermiwallet/repository/db/entity/account.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/error_widget.dart';
import 'package:fluttermiwallet/utils/widgets/switch_box_row_widget.dart';
import 'package:provider/provider.dart';

class AddWalletPage extends StatefulWidget {
  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  bool _isSaving = true;
  bool _isShowing = true;
  WalletsProvider _provider;
  int accId;
  int bankId;
  String _accountNameSelected = Strings.choose;
  String _bankNameSelected = Strings.choose;
  double _amount;
  TextEditingController _descController;
  bool _isChoosedAccount = false;
  bool _isChoosedBank = false;

  @override
  void initState() {
    _descController = TextEditingController();
    _provider = Provider.of<WalletsProvider>(context);
    super.initState();
  }

  _isEmpty() {
    if (_accountNameSelected != Strings.choose &&
        _bankNameSelected != Strings.choose) {
      _provider.updateAccount(
        Account(
          bankId: bankId,
          name: _accountNameSelected,
          balance: _amount,
          descriptions: _descController.text,
        ),
      );
      Navigator.of(context).pop();
    } else {
      if (_accountNameSelected == Strings.choose) {
        setState(() {
          _isChoosedAccount = true;
        });
      }
      if (_bankNameSelected == Strings.choose) {
        setState(() {
          _isChoosedBank = true;
        });
      }
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
              _isEmpty();
            });
          },
        ),
        body: ChangeNotifierProvider(
            create: (_) => Provider.of<WalletsProvider>(context, listen: false),
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
                _isChoosedAccount = false;
              });
              showModalBottomSheetWidget(
                context,
                ChangeNotifierProvider.value(
                  value: _provider,
                  child: ChooseWalletBottomSheetWidget(
                      context: context,
                      title: Strings.accountName,
                      isAccount: true,
                      onTap: (account) {
                        setState(
                          () {
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
            childWidget: chooseBottomSheet(_bankNameSelected),
            onPressed: () {
              setState(() {
                _isChoosedBank = false;
              });
              showModalBottomSheetWidget(
                context,
                ChangeNotifierProvider.value(
                  value: _provider,
                  child: ChooseWalletBottomSheetWidget(
                      context: context,
                      title: Strings.bank,
                      isAccount: false,
                      onTap: (bank) {
                        setState(() {
                          _bankNameSelected = bank.name;
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
            childWidget:
                descTextField((controller) => _descController = controller),
          ),
          boxRow(
            Strings.savingsAccount,
            secondWidget: CupertinoSwitch(
              activeColor: ColorRes.blueColor,
              value: _isSaving,
              onChanged: (bool) => setState(
                () {
                  _isSaving = !_isSaving;
                },
              ),
            ),
          ),
          boxRow(
            Strings.showInTotalBalance,
            secondWidget: CupertinoSwitch(
              activeColor: ColorRes.blueColor,
              value: _isShowing,
              onChanged: (bool) => setState(
                () {
                  _isShowing = !_isShowing;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
