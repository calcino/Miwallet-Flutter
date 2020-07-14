import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/dao/account_dao.dart';
import 'package:fluttermiwallet/db/dao/bank_dao.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';
import 'package:fluttermiwallet/db/entity/transaction.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';

class WalletsProvider with ChangeNotifier {
  final AppDatabase _db;
  List<Account> accounts = [];
  List<Transaction> transactions = [];
  List<Bank> banks = [];

  WalletsProvider(this._db);

  void insertFakeBank() async {
    _db.bankDao.insertBank(Bank('Saderat',DateTime.now().toIso8601String()));
  }

  void insertAccount() async {
//    await _db.accountDao.insertAccount(account);
    await _db.accountDao.insertAccount(
      Account( 1, "Saderat", 2000, "descriptions", DateTime.now().toIso8601String()),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 3578, "descriptions",
          DateTime.now().toIso8601String()),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 4538, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 42225, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 54, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 45388, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 48646, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 486486, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 486464, "descriptions", "createdDateTime"),
    );
    await _db.accountDao.insertAccount(
      Account(1, "Saderat", 378464, "descriptions", "createdDateTime"),
    );
    notifyListeners();
  }

  void updateAccouny(Account account) async {
    await _db.accountDao.updateAccount(account);
  }

  void getAllAccounts() async {
    accounts = await _db.accountDao.findAll();
//    accounts = [Account(1, 2, "Saderat", 320393, "Acount Back Saderat",
//        DateTime.now().toIso8601String())];
    print(accounts.toString());
    notifyListeners();
  }

  void getAllTransaction() async{
    transactions = await _db.transactionDao.findAll();
  }

  void insertTransfer(Transfer transfer) async{
    await _db.transferDao.insertTransfer(transfer);
  }

  void findAllBank() async{
    banks = await _db.bankDao.findAll();
  }
}
