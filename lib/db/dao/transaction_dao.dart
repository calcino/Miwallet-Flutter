import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/transaction.dart';

@dao
abstract class TransactionDao {

  @Query('SELECT * FROM Transactions')
  Future<List<Transaction>> findAll();

  @Query('SELECT * FROM Transactions WHERE id = :id')
  Stream<Transaction> findTransaction(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertTransaction(Transaction transaction);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTransaction(Transaction transaction);
}