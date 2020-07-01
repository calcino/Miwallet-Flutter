import 'package:flutter/material.dart';
import 'package:fluttermiwallet/features/home/ui/add_count.dart';
import 'package:fluttermiwallet/features/home/ui/home.dart';

class MiWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MI Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddCount(),
    );
  }
}