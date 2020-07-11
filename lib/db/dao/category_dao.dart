import 'package:floor/floor.dart';
import 'package:fluttermiwallet/db/entity/category.dart';

@dao
abstract class CategoryDao {

  @Query('SELECT * FROM Categories')
  Future<List<Category>> findAll();

  @Query('SELECT * FROM Categories WHERE id = :id')
  Stream<Category> findCategory(int id);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertCategory(Category category);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCategory(Category category);
}