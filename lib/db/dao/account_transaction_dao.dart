import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';

@dao
abstract class AccountTransactionDao {

  @Query('SELECT * FROM AccountTransaction')
  Future<List<AccountTransaction>> findAllAccountTransaction();

  @Query('SELECT * FROM AccountTransaction WHERE id = :id')
  Future<AccountTransaction> findAccountTransaction(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertAccountTransaction(AccountTransaction accountTransaction);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAccountTransaction(AccountTransaction accountTransaction);
}