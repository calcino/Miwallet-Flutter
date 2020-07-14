import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/category.dart' as category;
import 'package:fluttermiwallet/db/entity/subcategory.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['accountId'], parentColumns: ['id'], entity: Account),
  ForeignKey(
      childColumns: ['categoryId'],
      parentColumns: ['id'],
      entity: category.Category),
  ForeignKey(
      childColumns: ['subcategoryId'],
      parentColumns: ['id'],
      entity: Subcategory),
])
class Transaction {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int accountId;
  final double amount;
  final String dateTime;
  final String receiptImagePath;
  final int categoryId;
  final int subcategoryId;
  final String createdDateTime;
  final bool isIncome;

  Transaction(
      {this.id,
      @required this.accountId,
      @required this.amount,
      @required this.dateTime,
      @required this.receiptImagePath,
      @required this.categoryId,
      @required this.subcategoryId,
      @required this.createdDateTime,
      @required this.isIncome});
}
