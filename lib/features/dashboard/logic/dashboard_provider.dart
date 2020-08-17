import 'package:inject/inject.dart';

import '../../../base/base_provider.dart';
import '../../../repository/db/views/account_transaction_view.dart';
import '../../../repository/db/views/transaction_grouped_by_category.dart';
import '../../../repository/repository.dart';
import '../../../utils/date_range.dart';

class DashboardProvider extends BaseProvider {
  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;
  List<AccountTransactionView> transactions = [];
  List<TransactionGroupedByCategory> totalExpensesGroupedByCategory = [];
  List<TransactionGroupedByCategory> totalIncomeGroupedByCategory = [];
  List<TransactionGroupedByCategory> totalIncomeExpenseGroupedByCategory = [];
  bool isLoading = false;

  @provide
  DashboardProvider(Repository repository) : super(repository);

  void getAccountTransactions({DateRange dateRange = const DateRange()}) async {
    isLoading = true;
    var data = await repository.getAccountTransactions(dateRange: dateRange);
    totalIncome = 0;
    totalExpense = 0;
    data.forEach((transaction) {
      if (transaction.isIncome)
        totalIncome += transaction.amount;
      else
        totalExpense += transaction.amount;
    });
    totalBalance = totalIncome - totalExpense;
    await getTotalIncomeExpensesGroupedByCategoryId(dateRange: dateRange);
    transactions = data;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTotalIncomeExpensesGroupedByCategoryId(
      {DateRange dateRange = const DateRange()}) async {
    totalExpensesGroupedByCategory = await repository
        .getTotalExpensesGroupedByCategoryId(dateRange: dateRange);
    totalIncomeGroupedByCategory = await repository
        .getTotalExpensesGroupedByCategoryId(dateRange: dateRange);
    totalIncomeExpenseGroupedByCategory =
        List.from(totalIncomeGroupedByCategory)
          ..addAll(totalExpensesGroupedByCategory);
    return;
  }
}
