import 'package:floor/floor.dart';
import '../entity/transfer.dart';

@dao
abstract class TransferDao {

  @Query('SELECT * FROM Transfer')
  Future<List<Transfer>> findAll();

  @Query('SELECT * FROM Transfer WHERE id = :id')
  Stream<Transfer> findTransfer(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertTransfer(Transfer transfer);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTransfer(Transfer transfer);
}