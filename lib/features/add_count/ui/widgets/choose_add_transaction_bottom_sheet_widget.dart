import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/add_count/logic/add_transaction_provider.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class ChooseAddTransactionBottomSheetWidget extends StatelessWidget {
  BuildContext context;
  String title;
  Function(dynamic) onTap;

  ChooseAddTransactionBottomSheetWidget(
      {Key key, this.context, this.title,this.onTap}): super(key: key);

  AddTransactionProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider =
        Provider.of<AddTransactionProvider>(context, listen: false);
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
                          categoryListField(data[index].name, onTap: () {
                            onTap(data[index]);
                            Navigator.pop(context);
                          }),
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
