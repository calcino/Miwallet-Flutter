import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';

@dao
abstract class AccountTransactionDao {
  @Query('SELECT * FROM AccountTransaction WHERE id = :id')
  Future<AccountTransaction> findWithId(int id);

  @Query(
      'SELECT * FROM AccountTransactionView WHERE dateTime > :fromDate AND dateTime < :toDate')
  Stream<List<AccountTransactionView>> findAll(
      String fromDate, String toDate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAccountTransaction(AccountTransaction accountTransaction);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAccountTransaction(AccountTransaction accountTransaction);
}
