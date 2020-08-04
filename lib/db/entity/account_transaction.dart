import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/category.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';

@Entity(tableName: 'AccountTransaction', foreignKeys: [
  ForeignKey(
      childColumns: ['accountId'], parentColumns: ['id'], entity: Account),
  ForeignKey(
      childColumns: ['categoryId'], parentColumns: ['id'], entity: Category),
  ForeignKey(
      childColumns: ['subcategoryId'],
      parentColumns: ['id'],
      entity: Subcategory),
])
class AccountTransaction {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int accountId;
  final double amount;
  final String dateTime;
  final String receiptImagePath;
  final int categoryId;
  final int subcategoryId;
  final String createdDateTime = DateTime.now().toIso8601String();
  final bool isIncome;

  AccountTransaction(
      {this.id,
      @required this.accountId,
      @required this.amount,
      @required this.dateTime,
      @required this.receiptImagePath,
      @required this.categoryId,
      @required this.subcategoryId,
      @required this.isIncome});

  @override
  String toString() {
    return 'AccountTransaction: {id: $id, accountId: $accountId, amount: $amount,'
        'dateTime: $dateTime, receiptImagePath: $receiptImagePath,categoryId: $categoryId,'
        'subcategoryId: $subcategoryId,createdDateTime: $createdDateTime, isIncome: $isIncome}';
  }
}
