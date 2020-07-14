import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/account.dart';
import 'package:fluttermiwallet/db/entity/category.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['accountId'], parentColumns: ['id'], entity: Account),
  ForeignKey(
      childColumns: ['categoryId'], parentColumns: ['id'], entity: Category),
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

  Transaction(this.id, this.accountId, this.amount, this.dateTime,
      this.receiptImagePath, this.categoryId, this.subcategoryId, this.createdDateTime, this.isIncome);
}
