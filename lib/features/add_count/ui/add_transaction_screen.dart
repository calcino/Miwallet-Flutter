import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/features/add_count/ui/widgets/category_bottom_sheet_widget.dart';
import 'package:fluttermiwallet/features/add_count/ui/widgets/choose_add_transaction_bottom_sheet_widget.dart';
import 'package:fluttermiwallet/features/add_count/ui/widgets/image_picker_widgets.dart';
import 'package:fluttermiwallet/features/home/logic/home_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../repository/db/entity/account.dart';
import '../../../repository/db/entity/account_transaction.dart';
import '../../../res/colors.dart';
import '../../../res/strings.dart';
import '../../../utils/widgets/bottom_sheet_widget.dart';
import '../../../utils/widgets/custom_appbar.dart';
import '../../../utils/widgets/custom_text_field.dart';
import '../../../utils/widgets/error_widget.dart';
import '../../../utils/widgets/show_date_picker_widget.dart';
import '../../../utils/widgets/show_date_time_widget.dart';
import '../../add_count/logic/add_transaction_provider.dart';

class AddTransactionPage extends StatefulWidget {
  final bool _isIncome;

  @provide
  AddTransactionPage(this._isIncome);

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  DateTime _time = DateTime.now();
  DateTime _date = DateTime.now();
  PickedFile _imageFile;

  AddTransactionProvider _provider;
  double _amount;
  String _catNameSelected = Strings.choose;
  String _subCatSelected = Strings.choose;
  String _accountNameSelected = Strings.choose;
  int accId;
  int catId;
  int subId;
  bool _isChoosedCat = false;
  bool _isChoosedSub = false;
  bool _isChoosedAcc = false;

  TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<HomeProvider>(context, listen: false)
        .addTransactionProvider;
    _descController = TextEditingController();
    _provider.getAllAccount();
  }

  _isEmpty() {
    if (_accountNameSelected != Strings.choose &&
        _catNameSelected != Strings.choose &&
        _subCatSelected != Strings.choose) {
      _provider.insertTransaction(
        AccountTransaction(
            accountId: accId,
            amount: _amount,
            dateTime:
                "${DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute)}",
            //yyy-MM-ddTHH:mm:ss
            receiptImagePath: _imageFile.toString(),
            categoryId: catId,
            subcategoryId: subId,
            isIncome: widget._isIncome),
      );
      Navigator.of(context).pop();
    } else {
      if (_catNameSelected == Strings.choose) {
        setState(() {
          _isChoosedCat = true;
        });
      }
      if (_subCatSelected == Strings.choose) {
        setState(() {
          _isChoosedSub = true;
        });
      }
      if (_accountNameSelected == Strings.choose) {
        setState(() {
          _isChoosedAcc = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      width: 360,
      height: 640,
    );
    return ChangeNotifierProvider<AddTransactionProvider>(
      create: (_) => _provider,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(
              context,
              bottomCalcAppBar(onSubmitted: (amount) => _amount = amount),
              widget._isIncome ? Strings.addIncome : Strings.addExpense,
              saveOnTap: () {
            _isEmpty();
          }),
          body: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          errorTextWidget(_isChoosedCat, Strings.pleaseChooseCategory),
          customTextBox(
              marginTop: 19,
              label: Strings.category,
              childWidget: chooseBottomSheet(_catNameSelected),
              onPressed: () {
                setState(() {
                  _isChoosedCat = false;
                });
                showModalBottomSheetWidget(
                  context,
                  ChangeNotifierProvider.value(
                    value: _provider,
                    child: ChooseCategoryBottomSheetWidget(
                        isCategory: true,
                        onTap: (category) {
                          setState(() {
                            _catNameSelected = category.name;
                            catId = category.id;
                          });
                        }),
                  ),
                );
              }),
          errorTextWidget(_isChoosedSub, Strings.pleaseChooseSubCategory),
          customTextBox(
            marginTop: 13,
            marginBottom: 13,
            label: Strings.subcategory,
            childWidget: chooseBottomSheet(_subCatSelected),
            onPressed: () {
              setState(() {
                _isChoosedSub = false;
              });
              showModalBottomSheetWidget(
                context,
                ChangeNotifierProvider.value(
                  value: _provider,
                  child: ChooseCategoryBottomSheetWidget(
                      isCategory: false,
                      onTap: (subCategory) {
                        setState(() {
                          _subCatSelected = subCategory.name;
                          subId = subCategory.id;
                        });
                      }),
                ),
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
                  childWidget: dateTimeShow(
                    DateFormat("HH:mm").format(_time),
                  ),
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
          errorTextWidget(_isChoosedAcc, Strings.pleaseChooseAccount),
          customTextBox(
              marginTop: 15,
              label: Strings.fromWhichAccount,
              childWidget: chooseBottomSheet(_accountNameSelected),
              onPressed: () {
                setState(() {
                  _isChoosedAcc = false;
                });
                showModalBottomSheetWidget(
                  context,
                  ChangeNotifierProvider.value(
                    value: _provider,
                    child: ChooseAddTransactionBottomSheetWidget(
                        context: context,
                        title: Strings.fromWhichAccount,
                        onTap: (acc) {
                          setState(
                            () {
                              _accountNameSelected = acc.name;
                              accId = acc.id;
                            },
                          );
                        }),
                  ),
                );
              }),
          customTextBox(
            marginTop: 12,
            label: Strings.description,
            marginBottom: 23.5,
            height: 84,
            childWidget:
                descTextField((controller) => _descController = controller),
          ),
          Divider(
            height: ScreenUtil().setWidth(1),
            color: ColorRes.hintColor,
          ),
          ImagePickerButtonWidget(
            onSelectFile: (img) => setState(
              () {
                _imageFile = img;
              },
            ),
          ),
        ],
      ),
    );
  }
}
