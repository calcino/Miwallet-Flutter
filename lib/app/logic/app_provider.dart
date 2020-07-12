import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/database.dart';

class AppProvider with ChangeNotifier{
  final AppDatabase db;

  AppProvider(this.db);
}