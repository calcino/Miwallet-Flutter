import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class Wallet {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final double balance;

  const Wallet({this.id, @required this.name, @required this.balance});
}
