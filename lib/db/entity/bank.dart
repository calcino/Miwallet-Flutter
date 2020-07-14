import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class Bank {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String createdDateTime;

  Bank({this.id, @required this.name, @required this.createdDateTime});
}
