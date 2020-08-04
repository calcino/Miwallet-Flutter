import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String hexColor;
  final String createdDateTime = DateTime.now().toIso8601String();

  Category({this.id, @required this.name, @required this.hexColor});

  @override
  String toString() {
    return 'Category: {id: $id,name: $name,hexColor: $hexColor, createdDateTime: $createdDateTime}';
  }
}
