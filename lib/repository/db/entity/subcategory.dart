import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'category.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['categoryId'], parentColumns: ['id'], entity: Category)
])
class Subcategory {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final int categoryId;
  final String name;
  final String hexColor;
  final String createdDateTime = DateTime.now().toIso8601String();

  Subcategory(
      {this.id,
      @required this.categoryId,
      @required this.name,
      @required this.hexColor});

  @override
  String toString() {
    return 'Subcategory: {id: $id, categoryId: $categoryId, name: $name,'
        'hexColor: $hexColor, createdDateTime: $createdDateTime}';
  }
}
