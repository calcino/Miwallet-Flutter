import 'package:fluttermiwallet/base/base_provider.dart';
import 'package:fluttermiwallet/repository/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:fluttermiwallet/utils/date_range.dart';

class ReportProvider extends BaseProvider {
  List<AccountTransactionView> transactions = [];
  bool isLoading = false;

  ReportProvider(Repository repository) : super(repository);

  void getAccountTransactions({DateRange dateRange = const DateRange()}) async {
    isLoading = true;
    transactions =
        await repository.getAccountTransactions(dateRange: dateRange);
    isLoading = false;
    notifyListeners();
  }
}
