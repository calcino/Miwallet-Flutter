import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:fluttermiwallet/db/entity/category.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['categoryId'], parentColumns: ['id'], entity: Category)
])
class Subcategory {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final int categoryId;
  final String name;
  final String imagePath;
  final String createdDateTime;

  Subcategory(
      {this.id,
      @required this.categoryId,
      @required this.name,
      @required this.imagePath,
      @required this.createdDateTime});

  @override
  String toString() {
    return 'Subcategory: {id: $id, categoryId: $categoryId, name: $name,'
        'imagePath: $imagePath, createdDateTime: $createdDateTime}';
  }
}
