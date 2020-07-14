import 'package:flutter/material.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/features/wallets/ui/account_transaction.dart';
import 'package:fluttermiwallet/features/wallets/ui/accounts_screen.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:provider/provider.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';

class MiWalletApp extends StatelessWidget {
  final AppDatabase _db;

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
      home: ChangeNotifierProvider<WalletsProvider>(
          create: (ctx) =>
              WalletsProvider( Provider.of<AppProvider>(ctx,listen: false).db),
          child: AccountsScreen()),
    );
  }
}
