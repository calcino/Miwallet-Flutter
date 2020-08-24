import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/custom_radio_button.dart';

class RadioGroupWidgets extends StatefulWidget {
  @override
  _RadioGroupWidgetsState createState() => _RadioGroupWidgetsState();
}

class _RadioGroupWidgetsState extends State<RadioGroupWidgets> {
  int _radioValue = -1;
  @override
  Widget build(BuildContext context) {
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
}
