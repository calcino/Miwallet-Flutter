import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/wallets/ui/widgets/choose_wallet_bottom_sheet_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../features/wallets/logic/wallets_provider.dart';
import '../../../repository/db/entity/account.dart';
import '../../../repository/db/entity/transfer.dart';
import '../../../res/strings.dart';
import '../../../utils/widgets/bottom_sheet_widget.dart';
import '../../../utils/widgets/custom_appbar.dart';
import '../../../utils/widgets/custom_text_field.dart';
import '../../../utils/widgets/error_widget.dart';
import '../../../utils/widgets/show_date_picker_widget.dart';
import '../../../utils/widgets/show_date_time_widget.dart';

class MoneyTransferPage extends StatefulWidget {
  final int _sourceId;

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();

  MoneyTransferPage(this._sourceId);
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  DateTime _time = DateTime.now();
  DateTime _date = DateTime.now();
  WalletsProvider _provider;
  String _accountNameSelected = Strings.choose;
  int _destinationAccId;
  double _amount;
  TextEditingController _descController;
  bool _isChoosedAccount = false;

  _isEmptyField() {
    if (_accountNameSelected == Strings.choose) {
      setState(() {
        _isChoosedAccount = true;
      });
    } else {
      _provider.insertTransfer(
        Transfer(
          sourceAccountId: widget._sourceId,
          destinationAccountId: _destinationAccId,
          amount: _amount,
          dateTime:
              "${DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute)}",
          descriptions: _descController.text,
        ),
      );
    }
  }

  @override
  void initState() {
    _descController = TextEditingController();
    _provider = Provider.of<WalletsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
            context,
            bottomCalcAppBar(
                isExpanded: true, onSubmitted: (amount) => _amount = amount),
            Strings.moneyTransfer, saveOnTap: () {
          setState(() {
            _isEmptyField();
          });
        }),
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
          Selector<WalletsProvider, List<Account>>(
            selector: (ctx, provider) => provider.accounts,
            builder: (ctx, accounts, _) {
              return customTextBox(
                marginTop: 19,
                marginBottom: 12,
                label: Strings.toWhichAccount,
                childWidget: chooseBottomSheet(_accountNameSelected),
                onPressed: () {
                  showModalBottomSheetWidget(
                    context,
                    ChangeNotifierProvider.value(
                      value: _provider,
                      child: StatefulBuilder(
                        builder: (BuildContext contextz, StateSetter setState) {
                          setState(() {
                            _isChoosedAccount = false;
                          });
                          return ChooseWalletBottomSheetWidget(
                            context: ctx,
                            onTap: (account) {
                              setState(
                                () {
                                  _accountNameSelected = account.name;
                                  _destinationAccId = account.id;
                                },
                              );
                            },
                            title: Strings.account,
                            isAccount: true,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.time,
                  marginRight: 3.5,
                  childWidget: dateTimeShow(DateFormat("HH:mm").format(_time)),
                  onPressed: () => showDatePickerWidget(
                    context,
                    DateTimePickerMode.time,
                    "HH:mm",
                    (dateTime, _) => setState(
                      () {
                        _time = dateTime;
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.date,
                  marginLeft: 3.5,
                  childWidget: dateTimeShow(
                    DateFormat("dd MMMM,yyyy").format(_date),
                  ),
                  onPressed: () => showDatePickerWidget(
                    context,
                    DateTimePickerMode.date,
                    "dd MMMM,yyyy",
                    (dateTime, _) => setState(
                      () {
                        _date = dateTime;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          customTextBox(
            marginTop: 12,
            label: Strings.description,
            marginBottom: 0,
            height: 84,
            childWidget:
                descTextField((controller) => _descController = controller),
          ),
        ],
      ),
    );
  }

}
