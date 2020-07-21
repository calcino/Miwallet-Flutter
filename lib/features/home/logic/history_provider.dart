import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';

class HistoryProvider extends ChangeNotifier {
  final AppDatabase db;
  final DateTime fromDate, toDate;

  HistoryProvider(
      {@required this.db, @required this.fromDate, @required this.toDate});

  Stream<List<AccountTransactionView>> getAllTransaction() {
    return db.accountTransactionDao
        .findAll(fromDate.toIso8601String(), toDate.toIso8601String());
  }

  List<double> getTotalIncomeExpense(List<AccountTransactionView> list,
      [String dateIn = '']) {
    var totalIncome = 0.0;
    var totalExpense = 0.0;
    list.forEach((element) {
      if (element.accountTransactionId != null &&
          element.dateTime.contains(dateIn)) {
        if (element.isIncome)
          totalIncome += element.amount;
        else
          totalExpense += element.amount;
      }
    });
    return [totalIncome, totalExpense];
  }
}
