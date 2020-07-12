import 'package:flutter/material.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/features/wallets/ui/account_transaction.dart';
import 'package:fluttermiwallet/features/wallets/ui/accounts_screen.dart';
import 'package:fluttermiwallet/features/wallets/ui/edit_wallet.dart';
import 'package:fluttermiwallet/features/wallets/ui/money_transfer.dart';
import 'package:fluttermiwallet/features/dashboard/ui/dashboard.dart';
import 'package:fluttermiwallet/features/home/ui/home.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';
import 'package:provider/provider.dart';

class MiWalletApp extends StatelessWidget {
  final AppDatabase db;

  const MiWalletApp({Key key, @required this.db}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(db),
      child: _materialApp(),
    );
  }

  Widget _materialApp() {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: blueColor.toMaterial(), canvasColor: blueColor),
      home: MoneyTransfer(),
    );
  }
}
