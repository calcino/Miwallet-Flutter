import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String firstName;
  final String lastName;

  const User({this.id, @required this.firstName, @required this.lastName});
}
