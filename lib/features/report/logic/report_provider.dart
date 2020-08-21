import 'package:fluttermiwallet/base/base_provider.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:fluttermiwallet/utils/date_range.dart';
import 'package:fluttermiwallet/utils/income_expense.dart';

class ReportProvider extends BaseProvider {
  List<AccountTransactionView> transactionHistory = [];
  IncomeExpense incomeExpense = IncomeExpense(income: 0, expense: 0);
  bool isLoading = false;

  ReportProvider(Repository repository) : super(repository);

  void getAccountTransactions({DateRange dateRange = const DateRange()}) async {
    isLoading = true;
    transactionHistory =
        await repository.getAccountTransactions(dateRange: dateRange);
    isLoading = false;
    notifyListeners();
  }
}
