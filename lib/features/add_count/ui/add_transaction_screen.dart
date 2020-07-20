import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/entity/category.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';
import 'package:fluttermiwallet/features/add_count/logic/add_transaction_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/error_widget.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_picker_widget.dart';
import 'package:fluttermiwallet/utils/widgets/show_date_time_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  DateTime _time;
  DateTime _date;
  PickedFile _imageFile;
  ImagePicker _pickedFile = ImagePicker();
  bool _isPicked = false;
  AddTransactionProvider _provider;
  bool _isCategorySelected = false;
  bool _isSubCategorySelected = false;
  String _catNameSelected = Strings.choose;
  String _subCatSelected = Strings.choose;
  double _amount;
  String _description = "";
  bool _isAccountSelected = false;
  String _accountNameSelected = Strings.choose;
  int accId;
  int catId;
  int subId;
  bool _isChoosedCat = false;
  bool _isChoosedSub = false;
  bool _isChoosedAcc = false;

  _isEmptyField() {
    if (_accountNameSelected == Strings.choose) {
      _isChoosedAcc = true;
    }
    if (_catNameSelected == Strings.choose) {
      _isChoosedCat = true;
    }
    if (_subCatSelected == Strings.choose) {
      _isChoosedSub = true;
    } else {
      _isChoosedAcc = false;
      _isChoosedSub = false;
      _isChoosedCat = false;
      _provider.insertTransaction(
        AccountTransaction(
            accountId: accId,
            amount: _amount,
            dateTime: "${_date.toString()}T${_time.toString()}",
            //yyy-MM-ddTHH:mm:ss
            receiptImagePath: _imageFile.toString(),
            categoryId: catId,
            subcategoryId: subId,
            createdDateTime: DateTime.now().toIso8601String(),
            isIncome: false),
      );
    }
  }

  @override
  void initState() {
    var appProvider = context.read<AppProvider>();
    _provider = AddTransactionProvider(appProvider.db);
    _provider.getAllAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      width: 360,
      height: 640,
    );
    return ChangeNotifierProvider<AddTransactionProvider>(
      create: (ctx) => AddTransactionProvider(
          Provider.of<AppProvider>(ctx, listen: false).db),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(context, bottomCalcAppBar(), Strings.addExpense,
              saveOnTap: () {
            setState(() {
              _isEmptyField();
            });
          }),
          body: ChangeNotifierProvider<AddTransactionProvider>(
              create: (_) => _provider, child: _body(context)),
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
                    child: _chooseCategoryBtmSheet(true, onTap: (category) {
                      setState(() {
                        _isCategorySelected = true;
                        _catNameSelected = category.name;
                        catId = category.sourceId;
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
                  child: _chooseCategoryBtmSheet(false, onTap: (subCategory) {
                    setState(() {
                      _isSubCategorySelected = true;
                      _subCatSelected = subCategory.name;
                      subId = subCategory.sourceId;
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
                    _time == null ? "00:00" : DateFormat("HH:mm").format(_time),
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
                    _date == null
                        ? DateFormat('dd MMMM,yyyy').format(
                            DateTime.now(),
                          )
                        : DateFormat("dd MMMM,yyyy").format(_date),
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
                    child: _chooseBtmSheet(context, (acc) {
                      setState(
                        () {
                          _isAccountSelected = true;
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
            childWidget: descTextField((text) => _description = text),
          ),
          Divider(
            height: ScreenUtil().setWidth(1),
            color: ColorRes.hintColor,
          ),
          _imagePickerButton(),
        ],
      ),
    );
  }

  Widget _imagePickerButton() {
    return Container(
        width: ScreenUtil().setWidth(283),
        height: ScreenUtil().setHeight(113),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _isPicked ? ColorRes.hintColor : Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          bottom: ScreenUtil().setHeight(64),
          right: ScreenUtil().setWidth(18),
          left: ScreenUtil().setWidth(18),
        ),
        child: _setImageView());
  }

  _chooseCategoryBtmSheet(bool isCategory, {Function(dynamic) onTap}) {
    String _hintText =
        isCategory ? Strings.chooseCategory : Strings.chooseSubCategory;
    String _addText =
        isCategory ? Strings.addNewCategory : Strings.chooseSubCategory;
    if (isCategory) {
      _provider.getAllCategory();
    } else {
      _provider.getAllSubCategory();
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(_hintText, context),
          Selector<AddTransactionProvider, List<dynamic>>(
              selector: (_, provider) =>
                  isCategory ? provider.categories : provider.subCategories,
              builder: (_, data, __) {
                print('data : ${data.toString()}');
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? categoryListField(_addText, icon: Icons.add,
                              onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheetWidget(
                                  context, _addCategoryBtmSheet(isCategory));
                            })
                          : InkWell(
                              onTap: () {
                                onTap(isCategory
                                    ? (data[index - 1] as Category)
                                    : (data[index - 1] as Subcategory));
                              },
                              child: categoryListField(isCategory
                                  ? (data[index - 1] as Category)
                                      .name
                                      .toString()
                                  : (data[index - 1] as Subcategory)
                                      .name
                                      .toString()),
                            );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  _addCategoryBtmSheet(bool isCategory) {
    String name;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(100),
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.addCategory, context,
              isBackable: true, hasDone: true, onTap: () {
            isCategory
                ? _provider.insertCategory(
                    Category(
                      name: name,
                      imagePath: "null",
                      createdDateTime: DateTime.now().toIso8601String(),
                    ),
                  )
                : _provider.insertSubCategory(
                    Subcategory(
                      categoryId: 1,
                      name: name,
                      imagePath: "null",
                      createdDateTime: DateTime.now().toIso8601String(),
                    ),
                  );
          }),
          _labelText(Strings.nameCategory, marginTop: 20, marginBottom: 6),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setHeight(36),
            ),
            child: TextField(
              onSubmitted: (text) => name = text,
              style: TextStyle(
                color: ColorRes.hintColor,
                fontSize: ScreenUtil().setSp(12),
              ),
              maxLines: 1,
              decoration: InputDecoration(),
            ),
          ),
          _labelText(Strings.chooseAnIcon, marginTop: 15, marginBottom: 17),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setHeight(36),
              ),
              child: GridView.count(
                crossAxisCount: 6,
                children: List.generate(30, (index) => Icon(Icons.image)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _labelText(String label, {double marginTop, double marginBottom}) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(marginTop),
        bottom: ScreenUtil().setHeight(marginBottom),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setHeight(36),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: ColorRes.blueColor,
          fontSize: ScreenUtil().setSp(14),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    PickedFile _picture =
        await _pickedFile.getImage(source: ImageSource.gallery);

    if (_picture != null) {
      this.setState(() {
        _isPicked = true;
        _imageFile = _picture;
      });
    }
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    PickedFile _img = await _pickedFile.getImage(source: ImageSource.camera);
    if (_img != null) {
      this.setState(() {
        _isPicked = true;
        _imageFile = _img;
      });
    }
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile.path),
        alignment: Alignment.center,
        fit: BoxFit.cover,
      );
    } else {
      return InkWell(
        onTap: () => _showSelectionDialog(context),
        child: Image(
          image: AssetImage(
            "assets/images/image_picker.png",
          ),
          fit: BoxFit.cover,
          width: ScreenUtil().setWidth(92),
          height: ScreenUtil().setHeight(75),
        ),
      );
    }
  }

  Widget _chooseBtmSheet(BuildContext context, Function(Account) onTap) {
    _provider.getAllAccount();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.fromWhichAccount, context, isBackable: false),
          Selector<AddTransactionProvider, List<dynamic>>(
              selector: (_, provider) => provider.accounts,
              builder: (_, data, __) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
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