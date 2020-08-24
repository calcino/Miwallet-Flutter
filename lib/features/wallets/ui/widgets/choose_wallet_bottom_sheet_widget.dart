import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class ChooseWalletBottomSheetWidget extends StatelessWidget {
  BuildContext context;
  String title;
  bool isAccount;
  Function(dynamic) onTap;

  ChooseWalletBottomSheetWidget(
      {Key key, this.context, this.title, this.isAccount, this.onTap}): super(key: key);

  WalletsProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider =
        Provider.of<WalletsProvider>(context, listen: false);
    isAccount ? _provider.getAllAccounts() : _provider.findAllBank();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(title, context, isBackable: false),
          Selector<WalletsProvider, List<dynamic>>(
              selector: (ctx, provider) =>
                  isAccount ? provider.accounts : provider.banks,
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
