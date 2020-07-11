import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/subcategory.dart';

@dao
abstract class SubcategoryDao {

  @Query('SELECT * FROM Subcategories')
  Future<List<Subcategory>> findAll();

  @Query('SELECT * FROM Subcategories WHERE id = :id')
  Stream<Subcategory> findSubcategory(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertSubcategory(Subcategory subcategory);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSubcategory(Subcategory subcategory);
}