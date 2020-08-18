import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@DatabaseView(
    'SELECT AccountTransaction.id AS accountTransactionId, '
    'AccountTransaction.accountId AS accountId, '
    'AccountTransaction.categoryId AS categoryId, '
    'AccountTransaction.subcategoryId AS subcategoryId, '
    'AccountTransaction.dateTime AS dateTime, '
    'AccountTransaction.isIncome AS isIncome, '
    'AccountTransaction.amount AS amount, '
    'AccountTransaction.receiptImagePath AS receiptImagePath, '
    'Account.name AS accountName, '
    'Subcategory.name AS subcategoryName, '
    'Category.name AS categoryName, '
    'Category.hexColor AS categoryHexColor '
    'FROM AccountTransaction '
    'JOIN Category ON AccountTransaction.categoryId = Category.id '
    'JOIN Subcategory ON AccountTransaction.subcategoryId = Subcategory.id '
    'JOIN Account ON AccountTransaction.accountId = Account.id ',
    viewName: 'AccountTransactionView')
class AccountTransactionView {
  final int accountTransactionId;
  final int accountId;
  final int categoryId;
  final int subcategoryId;
  final bool isIncome;
  final double amount;
  final String dateTime;
  final String receiptImagePath;
  final String accountName;
  final String subcategoryName;
  final String categoryName;
  final String categoryHexColor;

  AccountTransactionView(
      {@required this.accountTransactionId,
      @required this.accountId,
      @required this.categoryId,
      @required this.subcategoryId,
      @required this.isIncome,
      @required this.amount,
      @required this.dateTime,
      @required this.receiptImagePath,
      @required this.accountName,
      @required this.subcategoryName,
      @required this.categoryName,
      @required this.categoryHexColor,
      });

  @override
  String toString() {
    return '''
    AccountTransactionView : {
    accountTransactionId: $accountTransactionId ,
    accountId: $accountId ,
    categoryId: $categoryId ,
    subcategoryId: $subcategoryId ,
    isIncome: $isIncome ,
    amount: $amount ,
    dateTime: $dateTime ,
    receiptImagePath: $receiptImagePath ,
    accountName: $accountName ,
    subcategoryName: $subcategoryName ,
    categoryName: $categoryName ,
    categoryHexColor: $categoryHexColor ,
    }\n''';
  }
}
