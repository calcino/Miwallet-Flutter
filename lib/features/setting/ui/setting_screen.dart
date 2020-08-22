import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/features/setting/ui/widgets/choose_setting_bottom_sheet.dart';
import 'package:fluttermiwallet/features/setting/ui/widgets/radio_group_widgets.dart';
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
                ChooseSettingBottomSheet(
                  context: context,
                  title: Strings.language,
                  onTap: (lang) {
                    setState(() {
                      _langNameSelected = lang;
                    });
                  },
                  data: languageList,
                ),
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
                ChooseSettingBottomSheet(
                  context: context,
                  title: Strings.currency,
                  onTap: (lang) {
                    setState(() {
                      _currencyNameSelected = lang;
                    });
                  },
                  data: currencyList,
                ),
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
          RadioGroupWidgets(),
          _labelContainer(Strings.data),
          GestureDetector(
            onTap: () {
              showModalBottomSheetWidget(
                context,
                ChooseSettingBottomSheet(
                  context: context,
                  title: Strings.backup,
                  onTap: (backUp) {
                    if (backUp == Strings.backuoOnGoogle) {
                      Navigator.pushNamed(context, RouteName.backUpPage);
                    }
                  },
                  data: backUpList,
                ),
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
            onTap: () {},
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
