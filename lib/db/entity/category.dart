import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String imagePath;
  final String createdDateTime;

  Category(
      {this.id,
      @required this.name,
      @required this.imagePath,
      @required this.createdDateTime});
}
