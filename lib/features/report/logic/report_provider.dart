import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/utils/date_range.dart';

class ReportProvider extends ChangeNotifier {
  final AppDatabase _db;
  List<AccountTransactionView> transactions = [];
  bool isLoading = false;

  ReportProvider(this._db);

  void getAccountTransactions({DateRange dateRange = const DateRange()}) async {
    isLoading = true;
    _db.accountTransactionDao
        .findAll(dateRange.from, dateRange.to)
        .listen((event) {
      transactions = event;
      isLoading = false;
      notifyListeners();
    });
  }
}