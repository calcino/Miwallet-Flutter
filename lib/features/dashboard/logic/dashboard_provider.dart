import 'package:fluttermiwallet/utils/custom_models/income_expense.dart';
import 'package:inject/inject.dart';

import '../../../base/base_provider.dart';
import '../../../repository/db/views/account_transaction_view.dart';
import '../../../repository/db/views/transaction_grouped_by_category.dart';
import '../../../repository/repository.dart';
import '../../../utils/custom_models/date_range.dart';

class DashboardProvider extends BaseProvider {
  IncomeExpense incomeExpense = IncomeExpense(income: 0, expense: 0);
  double totalBalance = 0;
  List<AccountTransactionView> transactions = [];
  List<TransactionGroupedByCategory> totalExpensesGroupedByCategory = [];
  List<TransactionGroupedByCategory> totalIncomeGroupedByCategory = [];
  List<TransactionGroupedByCategory> totalIncomeExpenseGroupedByCategory = [];

  @provide
  DashboardProvider(Repository repository) : super(repository);

  void getAccountTransactions({DateRange dateRange}) async {
    isLoading = true;
    var data = await repository.getAccountTransactions(dateRange: dateRange);
    var totalIncome = 0.0;
    var totalExpense = 0.0;
    data.forEach((transaction) {
      if (transaction.isIncome)
        totalIncome += transaction.amount;
      else
        totalExpense += transaction.amount;
    });
    totalBalance = totalIncome - totalExpense;
    incomeExpense = IncomeExpense(income: totalIncome, expense: totalExpense);
    await getTotalIncomeExpensesGroupedByCategoryId(dateRange: dateRange);
    transactions = data;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTotalIncomeExpensesGroupedByCategoryId(
      {DateRange dateRange}) async {
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
