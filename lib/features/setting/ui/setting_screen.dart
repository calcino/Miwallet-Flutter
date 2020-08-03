import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/route_name.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_radio_button.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/switch_box_row_widget.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _hasNotification = false;
  bool _hasDarkMode = false;
  bool _hasPassword = false;
  int _radioValue = -1;
  String _langNameSelected;
  String _currencyNameSelected;

  @override
  void initState() {
    _langNameSelected = languageList[0];
    _currencyNameSelected = currencyList[0];
    super.initState();
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
      title: Text(
        Strings.setting,
        style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _labelContainer(Strings.customize),
          customTextBox(
            childWidget: chooseBottomSheet(_langNameSelected),
            onPressed: () {
              showModalBottomSheetWidget(
                context,
                _chooseBtmSheet(context, Strings.language, (lang) {
                  setState(() {
                    _langNameSelected = lang;
                  });
                }, languageList),
              );
            },
            marginTop: ScreenUtil().setHeight(11),
            label: Strings.language,
          ),
          customTextBox(
            marginTop: ScreenUtil().setHeight(15),
            label: Strings.currency,
            childWidget: chooseBottomSheet(_currencyNameSelected),
            onPressed: () {
              showModalBottomSheetWidget(
                context,
                _chooseBtmSheet(context, Strings.currency, (lang) {
                  setState(() {
                    _currencyNameSelected = lang;
                  });
                }, currencyList),
              );
            },
          ),
          boxRow(
            Strings.notification,
            marginTop: 16,
            secondWidget: CupertinoSwitch(
              activeColor: ColorRes.blueColor,
              value: _hasNotification,
              onChanged: (bool) => setState(
                () {
                  _hasNotification = !_hasNotification;
                },
              ),
            ),
          ),
          boxRow(
            Strings.darkMode,
            marginTop: 10,
            secondWidget: CupertinoSwitch(
              activeColor: ColorRes.blueColor,
              value: _hasDarkMode,
              onChanged: (bool) => setState(
                () {
                  _hasDarkMode = !_hasDarkMode;
                },
              ),
            ),
          ),
          boxRow(
            Strings.password,
            marginTop: 10,
            marginBottom: 12,
            secondWidget: CupertinoSwitch(
              activeColor: ColorRes.blueColor,
              value: _hasPassword,
              onChanged: (bool) => setState(
                () {
                  _hasPassword = !_hasPassword;
                },
              ),
            ),
          ),
          _radioGroup(),
          _labelContainer(Strings.data),
          GestureDetector(
            onTap: () {
              showModalBottomSheetWidget(
                context,
                _chooseBtmSheet(context, Strings.backup, (backUp) {
                  if (backUp == Strings.backuoOnGoogle) {
                    Navigator.pushNamed(context, RouteName.backUpPage);
                  }
                }, backUpList),
              );
            },
            child: boxRow(
              Strings.backup,
              marginTop: 15,
              secondWidget: Icon(Icons.arrow_right),
              height: 50,
            ),
          ),
          boxRow(
            Strings.aboutMiWallet,
            marginTop: 10,
            marginBottom: 16,
            secondWidget: Icon(
              Icons.arrow_right,
              color: ColorRes.textColor,
            ),
            height: 50,
          ),
          _labelContainer(Strings.data),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteName.aboutUsPage),
            child: boxRow(
              Strings.aboutUs,
              marginTop: 15,
              secondWidget: Icon(
                Icons.arrow_right,
                color: ColorRes.textColor,
              ),
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: (){
            },
            child: boxRow(
              Strings.rateUs,
              marginTop: 10,
              secondWidget: Icon(
                Icons.arrow_right,
                color: ColorRes.textColor,
              ),
              height: 50,
            ),
          ),
          boxRow(
            Strings.appVersion,
            marginTop: 10,
            marginBottom: 5,
            color: Colors.transparent,
            secondWidget: Text(
              "2.2.2",
              style: TextStyle(
                color: ColorRes.blueColor,
                fontSize: ScreenUtil().setSp(14),
              ),
            ),
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _chooseBtmSheet(
      BuildContext context, String title, Function(dynamic) onTap, data) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(250),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(title, context, isBackable: false),
          Expanded(
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
                      child: categoryListField(data[index], hasIcon: false),
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

  Widget _radioGroup() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(21),
      ),
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RadioButton(
            description: Strings.pattern,
            value: 0,
            groupValue: _radioValue,
            onChanged: (value) => setState(
              () => _radioValue = value,
            ),
          ),
          RadioButton(
            description: Strings.pin,
            value: 1,
            groupValue: _radioValue,
            onChanged: (value) => setState(
              () => _radioValue = value,
            ),
          ),
          RadioButton(
            description: Strings.face,
            value: 2,
            groupValue: _radioValue,
            onChanged: (value) => setState(
              () => _radioValue = value,
            ),
          ),
          RadioButton(
            description: Strings.fingerPrint,
            value: 3,
            groupValue: _radioValue,
            onChanged: (value) => setState(
                  () => _radioValue = value,
            ),
          ),
        ],
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  Widget _labelContainer(String labelText) {
    return Container(
      alignment: Alignment.centerLeft,
      color: ColorRes.textColor.withOpacity(0.15),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(21),
        vertical: ScreenUtil().setHeight(4),
      ),
      child: Text(
        labelText,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(12),
          color: ColorRes.textColor,
        ),
      ),
    );
  }

  List<String> languageList = [
    Strings.english,
    Strings.arabic,
    Strings.persian,
  ];

  List<String> currencyList = [
    Strings.dollar,
    Strings.euro,
    Strings.rial,
  ];

  List<String> backUpList = [
    Strings.backupOnDevice,
    Strings.backuoOnGoogle,
  ];
}
