import 'package:floor/floor.dart';
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

  Account(this.bankId, this.name, this.balance, this.descriptions, this.createdDateTime,[this.id]);
}
