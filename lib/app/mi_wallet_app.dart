import 'package:flutter/material.dart';
import 'package:fluttermiwallet/features/home/ui/add_count.dart';
import 'package:fluttermiwallet/features/home/ui/home.dart';
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
      home: AddCount(),
    );
  }
}
