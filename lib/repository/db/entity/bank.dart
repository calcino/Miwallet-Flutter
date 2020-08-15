import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class Bank {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String createdDateTime = DateTime.now().toIso8601String();

  Bank({this.id, @required this.name});

  @override
  String toString() {
    return 'Bank: {id: $id, name: $name, createdDateTime: $createdDateTime}';
  }
}
