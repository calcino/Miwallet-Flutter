import 'package:floor/floor.dart';
import '../entity/bank.dart';

@dao
abstract class BankDao {

  @Query('SELECT * FROM Bank')
  Future<List<Bank>> findAll();

  @Query('SELECT * FROM Bank WHERE id = :id')
  Stream<Bank> findBank(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertBank(Bank bank);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBank(Bank bank);
}