import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'account.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['sourceAccountId'],
      parentColumns: ['id'],
      entity: Account),
  ForeignKey(
      childColumns: ['destinationAccountId'],
      parentColumns: ['id'],
      entity: Account),
])
class Transfer {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int sourceAccountId;
  final int destinationAccountId;
  final double amount;
  final String dateTime;
  final String descriptions;
  final String createdDateTime = DateTime.now().toIso8601String();

  Transfer(
      {this.id,
      @required this.sourceAccountId,
      @required this.destinationAccountId,
      @required this.amount,
      @required this.dateTime,
      @required this.descriptions});

  @override
  String toString() {
    return 'Transfer: {id: $id, sourceAccountId: $sourceAccountId, destinationAccountId: $destinationAccountId,'
        'amount: $amount, dateTime: $dateTime, descriptions: $descriptions, createdDateTime: $createdDateTime}';
  }
}
