import 'package:fluttermiwallet/base/base_provider.dart';
import 'package:fluttermiwallet/repository/db/entity/account.dart';
import 'package:fluttermiwallet/repository/db/entity/bank.dart';
import 'package:fluttermiwallet/repository/db/entity/transfer.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:fluttermiwallet/utils/custom_models/date_range.dart';

class WalletsProvider extends BaseProvider {
  List<Account> accounts = [];
  List<AccountTransactionView> transactions = [];
  List<Bank> banks = [];
  String subcategoryName = "";

  WalletsProvider(Repository repository) : super(repository);

  void insertAccount(Account account) async {
    await repository.insertAccount(account: account);
  }

  void updateAccount(Account account) async {
    await repository.updateAccount(account: account);
  }

  void getAllAccounts() async {
    accounts = await repository.getAllAccount();
    notifyListeners();
  }

  void getAllTransaction() async {
    transactions = await repository.getAccountTransactions(
        dateRange: DateRange(
            from: DateTime(2000, 1, 1).toIso8601String(),
            to: DateTime.now().add(Duration(days: 1)).toIso8601String()));
    notifyListeners();
  }

  void findSubCategory(int id) async {
    var subCategory = await repository.findSubCategory(id: id);
    subcategoryName = subCategory.name;
    notifyListeners();
  }

  void insertTransfer(Transfer transfer) async {
    await repository.insertTransfer(transfer: transfer);
  }

  void findAllBank() async {
    banks = await repository.getAllBank();
    notifyListeners();
  }
}
