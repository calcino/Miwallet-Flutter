import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_time_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoneyTransfer extends StatefulWidget {
  @override
  _MoneyTransferState createState() => _MoneyTransferState();
}

class _MoneyTransferState extends State<MoneyTransfer> {
  DateTime _time;
  DateTime _date;
  WalletsProvider _provider;
  bool _isAccountSelected = false;
  String _accountNameSelected = Strings.choose;
  double _amount;
  String _description;
  @override
  void initState() {
    _provider = Provider.of<WalletsProvider>(context, listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360,height: 640);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, bottomCalcAppBar(isExpanded: true), Strings.moneyTransfer,saveOnTap: ()=>_provider.insertTransfer(Transfer(sourceAccountId: null, destinationAccountId: null, amount: null, dateTime: null, descriptions: null, createdDateTime: null))),
        body: _body(),
      ),
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Selector<WalletsProvider, List<Account>>(
            selector: (ctx, provider) => _provider.accounts,
            builder: (ctx, accounts, child) {
              return customTextBox(
                marginTop: 19,
                marginBottom: 12,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.time,
                  marginRight: 3.5,
                  childWidget: dateTimeShow(_time == null
                      ? "00:00"
                      : DateFormat("HH:mm").format(_time)),
                  onPressed: () => _showTimePicker(),
                ),
              ),
              Expanded(
                child: customTextBox(
                  marginTop: 0,
                  label: Strings.date,
                  marginLeft: 3.5,
                  childWidget: dateTimeShow(
                    _date == null
                        ? DateFormat('dd MMMM,yyyy').format(
                      DateTime.now(),
                    )
                        : DateFormat("dd MMMM,yyyy").format(_date),
                  ),
                  onPressed: () => _showDatePicker(),
                ),
              ),
            ],
          ),
          customTextBox(
            marginTop: 12,
            label: Strings.description,
            marginBottom: 0,
            height: 84,
            childWidget: descTextField((text)=>_description=text),
          ),

        ],
      ),
    );
  }

  _showTimePicker() {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.time,
      dateFormat: "HH-mm",
      onConfirm: (datetime, list) => setState(
            () {
          _time = datetime;
        },
      ),
    );
  }

  _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      dateFormat: "yyyy-MMMM-dd",
      onConfirm: (datetime, list) => setState(
            () {
          _date = datetime;
        },
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
          categoryAppBar(Strings.selectBank,context,isBackable: false),
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
                      color: hintColor,
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
}
