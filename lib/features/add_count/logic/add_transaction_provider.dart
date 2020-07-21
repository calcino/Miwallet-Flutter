
import 'package:flutter/foundation.dart' hide Category;
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/entity/category.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';
import 'package:fluttermiwallet/utils/logger/logger.dart';

class AddTransactionProvider with ChangeNotifier {
  final AppDatabase _db;
  String subCategoryName="";
  String categoryName="";
  List<Category> categories = [];
  List<Account> accounts = [];
  List<Subcategory> subCategories = [];


  AddTransactionProvider(this._db);

  void insertAccount() async {
//    await _db.accountDao.insertAccount(account);
        await _db.accountDao.insertAccount(
      Account(id: 1,bankId: 1, name: "my acc", balance: 1000, descriptions: "chettori", createdDateTime: DateTime.now().toIso8601String()),
    );
    notifyListeners();
  }

  void insertTransaction(AccountTransaction transaction) async {
    await _db.accountTransactionDao.insertAccountTransaction(transaction);
    notifyListeners();
  }





  void insertCategory(Category category) async{
    await _db.categoryDao.insertCategory(category);
    notifyListeners();
  }

  void getAllAccount() async{
    accounts = await _db.accountDao.findAll();
    notifyListeners();
  }

  void insertSubCategory(Subcategory subCategory) async{
    await _db.subcategoryDao.insertSubcategory(subCategory);
    notifyListeners();
  }

  void getAllCategory() {
    _db.categoryDao.findAll().listen((event) {
      categories = event;
      notifyListeners();
    });
  }

  void getAllSubCategory() {
    _db.subcategoryDao.findAll().listen((event) {
      subCategories = event;
      notifyListeners();
    });
  }

}