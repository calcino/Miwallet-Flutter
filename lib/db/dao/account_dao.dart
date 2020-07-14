import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/account.dart';

@dao
abstract class AccountDao {

  @Query('SELECT * FROM Account')
  Future<List<Account>> findAll();

  @Query('SELECT * FROM Account WHERE id = :id')
  Stream<Account> findAccount(int id);
  
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertAccount(Account account);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAccount(Account account);
}