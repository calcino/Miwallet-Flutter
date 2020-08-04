import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/db/entity/category.dart' as category;
import 'package:fluttermiwallet/db/entity/subcategory.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/utils/logger/logger.dart';

class WalletsProvider with ChangeNotifier {
  final AppDatabase _db;
  List<Account> accounts = [];
  List<AccountTransactionView> transactions = [];
  List<Bank> banks = [];
  String subcategoryName = "";

  WalletsProvider(this._db);

  void insertFakeBank() async {
    _db.bankDao.insertBank(Bank(name: "saderat"));
    _db.bankDao.insertBank(Bank(name: "parsian"));
    _db.bankDao.insertBank(Bank(name: "pasargad"));
    _db.bankDao.insertBank(Bank(name: "ayande"));
  }

  void insertAccount(Account account) async {
    await _db.accountDao.insertAccount(account);
    notifyListeners();
  }

  void updateAccount(Account account) async {
    await _db.accountDao.updateAccount(account);
  }

  void getAllAccounts() async {
    accounts = await _db.accountDao.findAll();
    notifyListeners();
  }

  void getAllTransaction() async {
    _db.accountTransactionDao
        .findAll(DateTime(2000, 1, 1).toIso8601String(),
            DateTime.now().toIso8601String())
        .listen((event) {
      transactions = event;
      print(transactions.toString());
      notifyListeners();
    });
  }

  void findSubCategory(int id) async {
    var subCategory = await _db.subcategoryDao.findSubcategory(id);
    subcategoryName = subCategory.name;
    notifyListeners();
  }

  void insertTransfer(Transfer transfer) async {
    await _db.transferDao.insertTransfer(transfer);
  }

  void findAllBank() async {
    banks = await _db.bankDao.findAll();
  }
}
