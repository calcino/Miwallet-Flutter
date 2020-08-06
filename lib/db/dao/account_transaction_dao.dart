import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/account_transaction.dart';
import 'package:fluttermiwallet/db/views/account_transaction_view.dart';
import 'package:fluttermiwallet/db/views/transaction_grouped_by_category.dart';

@dao
abstract class AccountTransactionDao {
  @Query('SELECT * FROM AccountTransaction WHERE id = :id')
  Future<AccountTransaction> findWithId(int id);

  @Query(
      'SELECT * FROM AccountTransactionView WHERE dateTime >= :fromDate AND dateTime <= :toDate')
  Stream<List<AccountTransactionView>> findAll(String fromDate, String toDate);

  @Query(
      'SELECT * FROM TransactionGroupedByCategory WHERE dateTime >= :fromDate AND dateTime <= :toDate AND isIncome = :isIncome')
  Stream<List<TransactionGroupedByCategory>> findAllGroupedByCategoryId(
      String fromDate, String toDate,String isIncome);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAccountTransaction(AccountTransaction accountTransaction);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAccountTransaction(AccountTransaction accountTransaction);
}
