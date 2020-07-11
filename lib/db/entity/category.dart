
import 'package:floor/floor.dart';

@Entity(tableName: 'Categories')
class Category {

  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String imagePath;
  final String createdDateTime;

  Category(this.id, this.name, this.imagePath, this.createdDateTime);
}