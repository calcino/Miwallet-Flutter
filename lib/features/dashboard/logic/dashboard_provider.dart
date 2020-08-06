import 'package:flutter/foundation.dart' hide Category;
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/db/entity/category.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/db/views/transaction_grouped_by_category.dart';
import 'package:fluttermiwallet/utils/date_range.dart';
import 'package:fluttermiwallet/utils/logger/logger.dart';

class DashboardProvider extends ChangeNotifier {
  final AppDatabase _db;
  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;
  List<AccountTransactionView> transactions = [];
  List<TransactionGroupedByCategory> totalExpensesGroupedByCategory = [];
  bool isLoading = false;

  DashboardProvider(this._db);

  void getAccountTransactions({DateRange dateRange = const DateRange()}) async {
    isLoading = true;
    _db.accountTransactionDao
        .findAll(dateRange.from, dateRange.to)
        .listen((event) {
      totalIncome = 0;
      totalExpense = 0;
      transactions = event;

      event.forEach((transaction) {
        if (transaction.isIncome)
          totalIncome += transaction.amount;
        else
          totalExpense += transaction.amount;
      });
      isLoading = false;
      notifyListeners();
    });
  }

  void getTotalExpensesGroupedByCategoryId(
      {DateRange dateRange = const DateRange()}) {
    _db.accountTransactionDao
        .findAllGroupedByCategoryId(dateRange.from, dateRange.to,'0')
        .listen((event) {
      totalExpensesGroupedByCategory = event;
      notifyListeners();
    });
  }

  void getTotalIncomeByPercentage() {}

  void insertFakeTransfer() async {
    _db.transferDao.insertTransfer(Transfer(
        sourceAccountId: 1,
        destinationAccountId: 1,
        amount: 1001,
        dateTime: DateTime.now().toIso8601String(),
        descriptions: "khodam bara khodam enteghal dadam"));
  }

  void getTransactionView() {
    _db.accountTransactionDao
        .findAll(DateTime(2000, 1, 1).toIso8601String(),
            DateTime.now().toIso8601String())
        .listen((event) {
      print('fuck : ${event.length}');
    });
  }

  void getTransfers() async {
    _db.transferDao.findAll().then((value) => Logger.log(value.toString()));
  }

  void getCategories() {
    _db.categoryDao.findAll().listen((value) => Logger.log(value.toString()));
  }

  void getSubcategories() {
    _db.subcategoryDao
        .findAll()
        .listen((value) => Logger.log(value.toString()));
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
    for (var i = 0; i < 20; i++) {
      _db.categoryDao
          .insertCategory(Category(name: "category $i", hexColor: '#983038'))
          .then((value) => Logger.log('inserted a fake category $i'));
    }
  }

  void insertFakeSubcategory() async {
    for (var i = 0; i < 10; i++)
      _db.subcategoryDao
          .insertSubcategory(Subcategory(
              categoryId: i + 1, name: "subcategory $i", hexColor: "#892052"))
          .then((value) => Logger.log('inserted fake subcategory $i'));
  }

  void insertFakeBank() async {
    for (var i = 0; i < 20; i++)
      _db.bankDao.insertBank(Bank(name: "bank saderat $i"));
  }

  void insertFakeAccount() async {
    for (var i = 0; i < 10; i++)
      _db.accountDao.insertAccount(Account(
          bankId: 1,
          name: "account khodmam $i",
          balance: 20000000 + i.toDouble(),
          descriptions: "barye kharj khodam $i"));
  }

  void insertFakeAccountTransactions() async {
    for (var i = 0; i < 10; i++)
      _db.accountTransactionDao
          .insertAccountTransaction(AccountTransaction(
              accountId: i + 1,
              amount: i * 2.400,
              receiptImagePath: 'recipt/path',
              categoryId: i % 2 == 0 ? 1 : 2,
              subcategoryId: 1,
              dateTime: DateTime(2020, i, i).toIso8601String(),
              isIncome: i % 2 == 0))
          .then((value) => Logger.log('inserted fake account transaction $i'));
  }
}
