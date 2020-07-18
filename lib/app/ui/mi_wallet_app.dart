import 'package:flutter/material.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/features/add_count/logic/add_count_provider.dart';
import 'package:fluttermiwallet/features/add_count/ui/add_count.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/features/wallets/ui/account_transaction_screen.dart';
import 'package:fluttermiwallet/features/wallets/ui/accounts_screen.dart';
import 'package:fluttermiwallet/features/wallets/ui/edit_wallet.dart';
import 'package:fluttermiwallet/features/wallets/ui/money_transfer.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
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
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: blueColor.toMaterial(), canvasColor: blueColor),
      home: ChangeNotifierProvider<AddCountProvider>(
          create: (ctx) =>
              AddCountProvider( Provider.of<AppProvider>(ctx,listen: false).db),
          child: AddCount()),
    );
  }
}
