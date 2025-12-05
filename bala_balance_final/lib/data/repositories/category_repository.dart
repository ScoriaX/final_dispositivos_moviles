import '../database.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final db = AppDatabase.instance;

  Future<List<CategoryModel>> getAll() async {
    final database = await db.database;
    final maps = await database.query('categories', orderBy: 'name ASC');
    return maps.map((m) => CategoryModel.fromMap(m)).toList();
  }

  Future<int> insert(CategoryModel c) async {
    final database = await db.database;
    return await database.insert('categories', c.toMap());
  }

  Future<int> update(CategoryModel c) async {
    final database = await db.database;
    return await database.update(
      'categories',
      c.toMap(),
      where: 'id = ?',
      whereArgs: [c.id],
    );
  }

  Future<int> delete(int id) async {
    final database = await db.database;
    return await database.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<CategoryModel?> getById(int id) async {
    final database = await db.database;
    final maps = await database.query('categories', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return CategoryModel.fromMap(maps.first);
  }
}
