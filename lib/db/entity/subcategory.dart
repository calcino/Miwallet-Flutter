import 'package:floor/floor.dart';
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

  Subcategory(this.id, this.categoryId, this.name, this.imagePath, this.createdDateTime);
}
