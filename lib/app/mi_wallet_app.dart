import 'package:flutter/material.dart';
import 'package:fluttermiwallet/features/wallets/ui/account_transaction.dart';
import 'package:fluttermiwallet/features/wallets/ui/accounts_screen.dart';
import 'package:fluttermiwallet/features/wallets/ui/edit_wallet.dart';
import 'package:fluttermiwallet/features/wallets/ui/money_transfer.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';

class MiWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: blueColor.toMaterial(),
      ),
      home: MoneyTransfer(),
    );
  }
}
