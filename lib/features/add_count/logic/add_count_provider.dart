import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/dao/account_dao.dart';
import 'package:fluttermiwallet/db/dao/bank_dao.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';

class AddCountProvider with ChangeNotifier {
  final AppDatabase _db;


  AddCountProvider(this._db);

  void insertTransaction(AccountTransaction transaction) async {
    await _db.accountTransactionDao.insertAccountTransaction(transaction);
    notifyListeners();
  }

  void insertAccount(Account account) async {
    await _db.accountDao.insertAccount(account);
    notifyListeners();
  }


}