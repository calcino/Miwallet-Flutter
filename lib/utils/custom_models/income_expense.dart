import 'package:flutter/foundation.dart';

class IncomeExpense {
  final double income, expense;

  IncomeExpense({@required this.income,@required this.expense});

  @override
  String toString() {
    return 'IncomeExpense: {income: $income,expense: $expense}';
  }
}
