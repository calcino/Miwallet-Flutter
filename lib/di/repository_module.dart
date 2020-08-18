import 'package:fluttermiwallet/repository/db/database.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:inject/inject.dart';

@module
class RepositoryModule {

  @provide
  @singleton
  Future<AppDatabase> db() =>
      $FloorAppDatabase.databaseBuilder('miwallet.db').build();

  @provide
  @singleton
  Repository getRepository(Future<AppDatabase> db) => Repository(db);

}