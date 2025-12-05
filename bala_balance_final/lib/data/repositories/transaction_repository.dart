import '../database.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final db = AppDatabase.instance;

  Future<List<TransactionModel>> getAll() async {
    final database = await db.database;

    final maps = await database.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return maps.map((m) => TransactionModel.fromMap(m)).toList();
  }

  Future<int> insert(TransactionModel t) async {
    final database = await db.database;
    return await database.insert('transactions', t.toMap());
  }
}
