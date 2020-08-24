import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';

class ChooseSettingBottomSheet extends StatelessWidget {
  BuildContext context;
  String title;
  List<String> data;
  Function(dynamic) onTap;

  ChooseSettingBottomSheet({Key key,this.context,this.title,this.data,this.onTap}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(300),
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
          )
        ],
      ),
    );
  }
}
