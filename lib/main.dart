import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:fluttermiwallet/db/database.dart';

import 'app/ui/mi_wallet_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = await $FloorAppDatabase.databaseBuilder('miwallet.db').build();
  runApp(MiWalletApp(db: db));
}