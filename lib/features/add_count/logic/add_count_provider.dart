import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/dao/account_dao.dart';
import 'package:fluttermiwallet/db/dao/bank_dao.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/db/entity/transaction.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';

class AddCountProvider with ChangeNotifier {
  final AppDatabase _db;


  AddCountProvider(this._db);

  void insertTransaction(Transaction transaction) async {
    await _db.transactionDao.insertTransaction(transaction);

    notifyListeners();
  }


}