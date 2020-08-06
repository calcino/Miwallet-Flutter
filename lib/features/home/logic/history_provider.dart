import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/database.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/utils/date_range.dart';

class HistoryProvider extends ChangeNotifier {
  final AppDatabase db;

  HistoryProvider({@required this.db});

  Stream<List<AccountTransactionView>> getAllTransaction(
      {DateRange dateRange = const DateRange()}) {
    return db.accountTransactionDao.findAll(dateRange.from, dateRange.to);
  }

  List<double> getTotalIncomeExpense(List<AccountTransactionView> list,
      {DateRange dateRange = const DateRange()}) {
    var totalIncome = 0.0;
    var totalExpense = 0.0;
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
    return [totalIncome, totalExpense];
  }
}
