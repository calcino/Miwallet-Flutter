import 'package:fluttermiwallet/base/base_provider.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/repository/db/views/transaction_grouped_by_category.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:fluttermiwallet/utils/date_range.dart';
import 'package:inject/inject.dart';

class DashboardProvider extends BaseProvider {
  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;
  List<AccountTransactionView> transactions = [];
  List<TransactionGroupedByCategory> totalExpensesGroupedByCategory = [];
  bool isLoading = false;

  @provide
  DashboardProvider(Repository repository) : super(repository);

  void getAccountTransactions({DateRange dateRange = const DateRange()}) async {
    isLoading = true;
    transactions =
        await repository.getAccountTransactions(dateRange: dateRange);
    totalIncome = 0;
    totalExpense = 0;
    transactions.forEach((transaction) {
      if (transaction.isIncome)
        totalIncome += transaction.amount;
      else
        totalExpense += transaction.amount;
    });
    isLoading = false;
    notifyListeners();
  }

  void getTotalExpensesGroupedByCategoryId(
      {DateRange dateRange = const DateRange()}) async {
    totalExpensesGroupedByCategory = await repository
        .getTotalExpensesGroupedByCategoryId(dateRange: dateRange);
    notifyListeners();
  }

  void getTotalIncomeByPercentage() {}
}
