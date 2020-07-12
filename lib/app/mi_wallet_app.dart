import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:fluttermiwallet/features/add_count/ui/add_count.dart';
import 'package:fluttermiwallet/features/wallets/ui/account_transaction.dart';
import 'package:fluttermiwallet/features/wallets/ui/accounts_screen.dart';
import 'package:fluttermiwallet/features/wallets/ui/edit_wallet.dart';
import 'package:fluttermiwallet/features/wallets/ui/money_transfer.dart';
import 'package:fluttermiwallet/features/dashboard/ui/dashboard.dart';
import 'package:fluttermiwallet/features/home/ui/home.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';

class MiWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: blueColor.toMaterial(),
        canvasColor: blueColor
      ),
      home: HomePage(),
    );
  }
}
