import 'package:floor/floor.dart';
import '../entity/subcategory.dart';

@dao
abstract class SubcategoryDao {

  @Query('SELECT * FROM Subcategory')
  Future<List<Subcategory>> findAll();

  @Query('SELECT * FROM Subcategory WHERE id = :id')
  Future<Subcategory> findSubcategory(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertSubcategory(Subcategory subcategory);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSubcategory(Subcategory subcategory);
}