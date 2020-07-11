
import 'package:floor/floor.dart';

@Entity(tableName: 'Banks')
class Bank {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String createdDateTime;

  Bank(this.id, this.name, this.createdDateTime);
}