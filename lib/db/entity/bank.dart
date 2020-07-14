
import 'package:floor/floor.dart';

@entity
class Bank {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String createdDateTime;

  Bank(this.name, this.createdDateTime,[this.id]);
}