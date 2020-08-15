import 'package:fluttermiwallet/base/base_provider.dart';
import 'package:fluttermiwallet/repository/db/entity/account.dart';
import 'package:fluttermiwallet/repository/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/repository/db/entity/category.dart';
import 'package:fluttermiwallet/repository/db/entity/subcategory.dart';
import 'package:fluttermiwallet/repository/repository.dart';

class AddTransactionProvider extends BaseProvider {
  String subCategoryName = "";
  String categoryName = "";
  List<Category> categories = [];
  List<Account> accounts = [];
  List<Subcategory> subCategories = [];

  AddTransactionProvider(Repository repository) : super(repository);

  void insertTransaction(AccountTransaction transaction) async {
    await repository.insertAccountTransaction(transaction: transaction);
  }

  void insertCategory(Category category) async {
    await repository.insertCategory(category: category);
  }

  void getAllAccount() async {
    accounts = await repository.getAllAccount();
    notifyListeners();
  }

  void insertSubCategory(Subcategory subCategory) async {
    await repository.insertSubCategory(subcategory: subCategory);
  }

  void getAllCategory() async {
    categories = await repository.getAllCategory();
    notifyListeners();
  }

  void getAllSubCategory() async {
    subCategories = await repository.getAllSubCategory();
    notifyListeners();
  }
}
