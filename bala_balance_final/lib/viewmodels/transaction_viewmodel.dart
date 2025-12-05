import 'package:flutter/foundation.dart';
import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repository.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository repo = TransactionRepository();

  List<TransactionModel> transactions = [];
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();

    transactions = await repo.getAll();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel t) async {
    await repo.insert(t);
    await load(); // Recarga lista de transacciones
  }
}
