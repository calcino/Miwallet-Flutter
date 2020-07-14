import 'package:flutter/material.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/features/dashboard/logic/dashboard_provider.dart';
import 'package:fluttermiwallet/features/dashboard/ui/dashboard.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';
import 'package:provider/provider.dart';

class MiWalletApp extends StatelessWidget {
  final AppDatabase _db;

  const MiWalletApp(this._db);

  @override
  Widget build(BuildContext context) {
    return _materialApp();
  }

  Widget _materialApp() {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: blueColor.toMaterial(), canvasColor: blueColor),
      home: ChangeNotifierProvider<DashboardProvider>(
          create: (ctx) => DashboardProvider(_db), child: Dashboard()),
    );
  }
}
