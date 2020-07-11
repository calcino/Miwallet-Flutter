import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/transfer.dart';

@dao
abstract class TransferDao {

  @Query('SELECT * FROM Transfers')
  Future<List<Transfer>> findAll();

  @Query('SELECT * FROM Transfers WHERE id = :id')
  Stream<Transfer> findTransfer(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertTransfer(Transfer transfer);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTransfer(Transfer transfer);
}