import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';

import '../utils/custom_models/date_range.dart';
import '../utils/logger/logger.dart';
import 'db/database.dart';
import 'db/entity/account.dart';
import 'db/entity/account_transaction.dart';
import 'db/entity/bank.dart';
import 'db/entity/category.dart';
import 'db/entity/subcategory.dart';
import 'db/entity/transfer.dart';
import 'db/views/account_transaction_view.dart';
import 'db/views/transaction_grouped_by_category.dart';

class Repository {
  final Future<AppDatabase> database;

  @provide
  Repository(this.database);

  Future<void> insertAccount({@required Account account}) async {
    var db = await database;
    return await db.accountDao.insertAccount(account);
  }

  Future<void> updateAccount({@required Account account}) async {
    var db = await database;
    return await db.accountDao.updateAccount(account);
  }

  Future<void> insertAccountTransaction(
      {@required AccountTransaction transaction}) async {
    var db = await database;
    return await db.accountTransactionDao.insertAccountTransaction(transaction);
  }

  Future<void> insertCategory({@required Category category}) async {
    var db = await database;
    return await db.categoryDao.insertCategory(category);
  }

  Future<List<Account>> getAllAccount() async {
    var db = await database;
    return await db.accountDao.findAll();
  }

  Future<void> insertSubCategory({@required Subcategory subcategory}) async {
    var db = await database;
    return await db.subcategoryDao.insertSubcategory(subcategory);
  }

  Future<Subcategory> findSubCategory({@required int id}) async {
    var db = await database;
    return await db.subcategoryDao.findSubcategory(id);
  }

  Future<List<Category>> getAllCategory() async {
    var db = await database;
    return await db.categoryDao.findAll();
  }

  Future<List<Subcategory>> getAllSubCategory() async {
    var db = await database;
    return await db.subcategoryDao.findAll();
  }

  Future<List<AccountTransactionView>> getAccountTransactions(
      {DateRange dateRange}) async {
    var db = await database;
    var data = await db.accountTransactionDao.findAll(
        dateRange != null ? dateRange.from : '',
        dateRange != null ? dateRange.to : '');
    Logger.log('transactions: ${data.toString()}');
    return data;
  }

  Future<List<TransactionGroupedByCategory>>
      getTotalExpensesGroupedByCategoryId({DateRange dateRange}) async {
    var db = await database;
    var data = await db.accountTransactionDao
        .findAllGroupedByCategoryId(dateRange.from, dateRange.to, false);
    return data;
  }

  Future<List<TransactionGroupedByCategory>> getTotalIncomeGroupedByCategoryId(
      {DateRange dateRange}) async {
    var db = await database;
    var data = await db.accountTransactionDao
        .findAllGroupedByCategoryId(dateRange?.from, dateRange?.to, true);
    return data;
  }

  Future<void> insertTransfer({@required Transfer transfer}) async {
    var db = await database;
    return await db.transferDao.insertTransfer(transfer);
  }

  Future<void> insertBank({@required Bank bank}) async {
    var db = await database;
    return await db.bankDao.insertBank(bank);
  }

  Future<List<Bank>> getAllBank() async {
    var db = await database;
    return await db.bankDao.findAll();
  }

  /// insert fake data for testing
  Future<void> insertFakeDataToDB() async {
    //category
    for (var i = 0; i < 20; i++) {
      await insertCategory(
          category: Category(name: "category $i", hexColor: '#983038'));
    }

    //subcategory
    for (var i = 0; i < 10; i++)
      await insertSubCategory(
          subcategory: Subcategory(
              categoryId: i + 1, name: "subcategory $i", hexColor: "#892052"));

    //bank
    for (var i = 0; i < 20; i++)
      await insertBank(bank: Bank(name: "bank saderat $i"));

    //account
    for (var i = 0; i < 10; i++)
      await insertAccount(
          account: Account(
              bankId: 1,
              name: "account khodmam $i",
              balance: 20000000 + i.toDouble(),
              descriptions: "barye kharj khodam $i"));

    //transaction
    for (var i = 0; i < 10; i++)
      await insertAccountTransaction(
          transaction: AccountTransaction(
              accountId: i + 1,
              amount: i * 2.400,
              receiptImagePath: 'recipt/path',
              categoryId: i % 2 == 0 ? 1 : 2,
              subcategoryId: 1,
              dateTime: DateTime(2020, i, i).toIso8601String(),
              isIncome: i % 2 == 0));

    //transfer
    await insertTransfer(
        transfer: Transfer(
            sourceAccountId: 1,
            destinationAccountId: 1,
            amount: 1001,
            dateTime: DateTime.now().toIso8601String(),
            descriptions: "khodam bara khodam enteghal dadam"));
    return;
  }
}
