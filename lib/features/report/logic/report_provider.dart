import '../../../base/base_provider.dart';
import '../../../repository/db/entity/category.dart';
import '../../../repository/db/views/account_transaction_view.dart';
import '../../../repository/repository.dart';
import '../../../utils/custom_models/filter_transactions_model.dart';
import '../../../utils/custom_models/income_expense.dart';

class ReportProvider extends BaseProvider {
  List<AccountTransactionView> transactionHistory = [];
  int _numberOfTransactions = 0;

  int get numberOfTransactions => _numberOfTransactions;
  double _averageCostPerDay = 0.0;

  double get averageCostPerDay => _averageCostPerDay;

  //todo calculate averageCostPerDay and numberOfTransactions

  IncomeExpense incomeExpense = IncomeExpense(income: 0, expense: 0);
  bool isLoading = false;

  ReportProvider(Repository repository) : super(repository);

  void getAccountTransactions(
      FilterTransactionModel filterTransactionModel) async {
    isLoading = true;
    transactionHistory = await repository.getAccountTransactions(
        dateRange: filterTransactionModel.dateRange);
    isLoading = false;
    notifyListeners();
  }

  Future<List<Category>> getCategories() {
    return repository.getAllCategory();
  }
}
