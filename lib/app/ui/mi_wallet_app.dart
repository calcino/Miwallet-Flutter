import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/route_name.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/navigator/navigation.dart';
import 'package:provider/provider.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';

class MiWalletApp extends StatelessWidget {
  final AppDatabase db;

  const MiWalletApp({Key key, this.db}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(db),
      child: _materialApp(context),
    );
  }

  Widget _materialApp(BuildContext context) {
    ScreenUtil.init(width: 320,height: 640,allowFontScaling: true);
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: ColorRes.blueColor.toMaterial(), canvasColor: ColorRes.blueColor),
      onGenerateRoute: Navigation.generateRoute,
      initialRoute: RouteName.addTransactionPage,
    );
  }
}
