import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/error_widget.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_picker_widget.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_time_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoneyTransferPage extends StatefulWidget {
  int _sourceId;

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
          dateTime: "${DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute)}",
          descriptions: _descController.text,
          createdDateTime: DateTime.now().toIso8601String(),
        ),
      );
    }
  }

  @override
  void initState() {
    _descController = TextEditingController();
    var appProvider = context.read<AppProvider>();
    _provider = WalletsProvider(appProvider.db);
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
              isExpanded: true,
                onSubmitted: (amount) => _amount = amount
            ),
            Strings.moneyTransfer, saveOnTap: () {
          setState(() {
            _isEmptyField();
          });
        }),
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
          Selector<WalletsProvider, List<Account>>(
            selector: (ctx, provider) => _provider.accounts,
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
                          return _chooseBtmSheet(ctx, (account) {
                            setState(
                              () {
                                _accountNameSelected = account.name;
                                _destinationAccId = account.id;
                              },
                            );
                          });
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
                  childWidget: dateTimeShow(DateFormat("dd MMMM,yyyy").format(_date),
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
            childWidget: descTextField((controller) => _descController = controller),
          ),
        ],
      ),
    );
  }

  Widget _chooseBtmSheet(
    BuildContext context,
    Function(Account) onTap,
  ) {
    _provider.getAllAccounts();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.account, context, isBackable: false),
          Selector<WalletsProvider, List<Account>>(
              selector: (ctx, provider) => provider.accounts,
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
}
