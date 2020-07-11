import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/account_dao.dart';
import 'dao/bank_dao.dart';
import 'dao/category_dao.dart';
import 'dao/subcategory_dao.dart';
import 'dao/transaction_dao.dart';
import 'dao/transfer_dao.dart';

import 'entity/account.dart';
import 'entity/bank.dart';
import 'entity/category.dart';
import 'entity/subcategory.dart';
import 'entity/transaction.dart';
import 'entity/transfer.dart';

part 'database.g.dart'; // the generated code will be there

@Database(
    version: 1,
    entities: [Account, Bank, Category, Subcategory, Transaction, Transfer])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;

  BankDao get bankDao;

  CategoryDao get categoryDao;

  SubcategoryDao get subcategoryDao;

  TransactionDao get transactionDao;

  TransferDao get transferDao;
}
