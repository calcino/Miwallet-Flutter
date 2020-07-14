import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermiwallet/db/entity/bank.dart';

@Entity(foreignKeys: [
  ForeignKey(childColumns: ['bankId'], parentColumns: ['id'], entity: Bank)
])
class Account {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int bankId;
  final String name;
  final double balance;
  final String descriptions;
  final String createdDateTime;

  Account(
      {this.id,
      @required this.bankId,
      @required this.name,
      @required this.balance,
      @required this.descriptions,
      @required this.createdDateTime});
}
