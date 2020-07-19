import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier{
  final AppDatabase _db;

  HomeProvider(this._db);
}