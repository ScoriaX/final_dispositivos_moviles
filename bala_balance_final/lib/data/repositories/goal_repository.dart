// Descripción: Repositorio de Meta
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import '../database.dart';
import '../models/goal_model.dart';

class GoalRepository {
  final db = AppDatabase.instance;

  Future<List<GoalModel>> getAll() async {
    final database = await db.database;
    final maps = await database.query('goals', orderBy: 'id DESC');
    return maps.map((m) => GoalModel.fromMap(m)).toList();
  }

  Future<int> insert(GoalModel g) async {
    final database = await db.database;
    return await database.insert('goals', g.toMap());
  }

  Future<int> update(GoalModel g) async {
    final database = await db.database;
    return await database.update(
      'goals',
      g.toMap(),
      where: 'id = ?',
      whereArgs: [g.id],
    );
  }

  Future<int> delete(int id) async {
    final database = await db.database;
    return await database.delete('goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<GoalModel?> getById(int id) async {
    final database = await db.database;
    final maps = await database.query('goals', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return GoalModel.fromMap(maps.first);
  }
}
