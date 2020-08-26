import '../../../base/base_provider.dart';
import '../../../features/add_count/logic/add_transaction_provider.dart';
import '../../../repository/db/views/account_transaction_view.dart';
import '../../../repository/repository.dart';
import '../../../utils/custom_models/date_range.dart';
import '../../../utils/custom_models/income_expense.dart';

class HomeProvider extends BaseProvider {
  List<AccountTransactionView> transactions = [];
  final AddTransactionProvider addTransactionProvider;

  HomeProvider(Repository repository, this.addTransactionProvider)
      : super(repository);

  void getAllTransaction({DateRange dateRange}) async {
    isLoading = true;
    transactions =
        await repository.getAccountTransactions(dateRange: dateRange);
    isLoading = false;
    notifyListeners();
  }

  IncomeExpense getTotalIncomeExpense(List<AccountTransactionView> list,
      {DateRange dateRange}) {
    var totalIncome = 0.0;
    var totalExpense = 0.0;

    if (dateRange != null) {
      list.forEach((element) {
        if (element.accountTransactionId != null &&
            DateTime.parse(element.dateTime)
                .isBefore(DateTime.parse(dateRange.to)) &&
            DateTime.parse(element.dateTime)
                .isAfter(DateTime.parse(dateRange.from))) {
          if (element.isIncome)
            totalIncome += element.amount;
          else
            totalExpense += element.amount;
        }
      });
    } else {
      list.forEach((element) {
        if (element.accountTransactionId != null) {
          if (element.isIncome)
            totalIncome += element.amount;
          else
            totalExpense += element.amount;
        }
      });
    }

    return IncomeExpense(income: totalIncome, expense: totalExpense);
  }
}
