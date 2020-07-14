import 'package:flutter/foundation.dart' hide Category;
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/db/entity/category.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';
import 'package:fluttermiwallet/utils/logger/logger.dart';

class DashboardProvider extends ChangeNotifier {
  final AppDatabase _db;
  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;

  List<AccountTransaction> transactions = [];

  DashboardProvider(this._db);

  void changeData() {
    totalBalance += 200;
    totalIncome += 3;
    totalExpense += 1;

    notifyListeners();
  }


  void getAccountTransactions() async {
    _db.accountTransactionDao.findAllAccountTransaction().then((value) {
      value.forEach((element) {
        Logger.log(element.toString());
      });
    });
  }

  void insertFakeTransfer() async {
    await _db.transferDao.insertTransfer(Transfer(
        sourceAccountId: 1,
        destinationAccountId: 1,
        amount: 1001,
        dateTime: DateTime.now().toIso8601String(),
        descriptions: "khodam bara khodam enteghal dadam",
        createdDateTime: DateTime.now().toIso8601String()));
  }

  void getTransfers() async {
    _db.transferDao.findAll().then((value) => Logger.log(value.toString()));
  }

  void getCategories() async {
    _db.categoryDao.findAll().then((value) => Logger.log(value.toString()));
  }

  void getSubcategories() async {
    _db.subcategoryDao.findAll().then((value) => Logger.log(value.toString()));
  }

  void getAllAccounts() async {
    _db.accountDao.findAll().then((value) {
      Logger.log(value.toString());
    });
  }

  void getAllBanks() async {
    _db.bankDao.findAll().then((value) {
      value.forEach((element) {
        Logger.log(element.toString());
      });
    });
  }

  void insertFakeCategory() async {
    _db.categoryDao
        .insertCategory(Category(
            name: "category 0",
            imagePath: 'category/img',
            createdDateTime: DateTime.now().toIso8601String()))
        .then((value) => Logger.log('inserted a fake category'));
  }

  void insertFakeSubcategory() async {
    _db.subcategoryDao
        .insertSubcategory(Subcategory(
            categoryId: 1,
            name: "subcategory 0",
            imagePath: "subcategory/path",
            createdDateTime: DateTime.now().toIso8601String()))
        .then((value) => Logger.log('inserted fake subcategory'));
  }

  void insertFakeBank() async {
    _db.bankDao.insertBank(Bank(
        name: "bank saderat",
        createdDateTime: DateTime.now().toIso8601String()));
  }

  void insertFakeAccount() async {
    _db.accountDao.insertAccount(Account(
        bankId: 1,
        name: "account khodmam",
        balance: 20000000,
        descriptions: "barye kharj khodam",
        createdDateTime: DateTime.now().toIso8601String()));
  }


  void insertFakeAccountTransactions() async {
    _db.accountTransactionDao
        .insertAccountTransaction(AccountTransaction(
        accountId: 1,
        amount: 1 * 2.400,
        receiptImagePath: 'recipt/path',
        categoryId: 1,
        subcategoryId: 1,
        createdDateTime: DateTime.now().toIso8601String(),
        dateTime: DateTime.now().toIso8601String(),
        isIncome: 1 % 2 == 0))
        .then((value) => Logger.log('inserted fake account transaction'));
  }
}
