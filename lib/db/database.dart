import 'dart:async';
import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/db/views/transaction_grouped_by_category.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/account_dao.dart';
import 'dao/bank_dao.dart';
import 'dao/category_dao.dart';
import 'dao/subcategory_dao.dart';
import 'dao/transfer_dao.dart';
import 'dao/account_transaction_dao.dart';

import 'entity/account.dart';
import 'entity/bank.dart';
import 'entity/category.dart';
import 'entity/subcategory.dart';
import 'entity/transfer.dart';
import 'entity/account_transaction.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  Account,
  Bank,
  Category,
  Subcategory,
  Transfer,
  AccountTransaction,
], views: [
  AccountTransactionView,
  TransactionGroupedByCategory
])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;

  BankDao get bankDao;

  CategoryDao get categoryDao;

  SubcategoryDao get subcategoryDao;

  TransferDao get transferDao;

  AccountTransactionDao get accountTransactionDao;
}
