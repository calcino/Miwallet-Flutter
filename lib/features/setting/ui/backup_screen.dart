import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/setting/ui/widgets/choose_setting_bottom_sheet.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:fluttermiwallet/utils/widgets/custom_appbar.dart';
import 'package:fluttermiwallet/utils/widgets/custom_text_field.dart';
import 'package:fluttermiwallet/utils/widgets/switch_box_row_widget.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool _hasAutoBackup = true;
  String _backupKind;
  double _gmail;
  TextEditingController _accountController;

  @override
  void initState() {
    _backupKind = _backUpKindList[0];
    _accountController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360, height: 640);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: _body()),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        Strings.backup,
        style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.white),
      ),
      centerTitle: true,
      bottom: bottomCalcAppBar(label: Strings.googleAccount,isCalculator: false,listener: (controller){
        _accountController = controller;
      }),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          customTextBox(
            marginTop: 19,
            label: Strings.backuoToGoogle,
            childWidget: chooseBottomSheet(_backupKind),
            onPressed: () {
              showModalBottomSheetWidget(
                context,
                ChooseSettingBottomSheet(
                  context:context,
                  title:Strings.backuoToGoogle,
                  data:_backUpKindList,
                  onTap:(sort) {
                    setState(
                      () {
                        _backupKind = sort;
                      },
                    );
                  },
                ),
              );
            },
          ),
          boxRow(
            Strings.automaticBackup,
            marginTop: 12,
            secondWidget: CupertinoSwitch(
              activeColor: ColorRes.blueColor,
              value: _hasAutoBackup,
              onChanged: (bool) => setState(
                () {
                  _hasAutoBackup = !_hasAutoBackup;
                },
              ),
            ),
          ),
          boxRow(
            Strings.manualBackup,
            marginTop: 12,
            marginBottom: 22.5,
            secondWidget: Icon(Icons.arrow_right,color: ColorRes.textColor,),
          ),
          Divider(
            height: ScreenUtil().setHeight(2),
          ),
          textBox(Strings.lastBackup, ColorRes.textColor),
          textBox("Google Drive: 29 July, 09:30", ColorRes.hintColor,marginTop: 11),
        ],
      ),
    );
  }

  Widget textBox(String title,Color color,{marginTop=21.5}){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(marginTop),left: ScreenUtil().setWidth(30),),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: ScreenUtil().setSp(14),
        ),
      ),
    );
  }



  List<String> _backUpKindList = [
    Strings.daily,
    Strings.weekly,
    Strings.monthly,
    Strings.yearly,
  ];
}
