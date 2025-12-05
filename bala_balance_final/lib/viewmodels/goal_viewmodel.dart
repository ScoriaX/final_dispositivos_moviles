import 'package:flutter/foundation.dart';
import '../data/models/goal_model.dart';
import '../data/repositories/goal_repository.dart';

class GoalViewModel extends ChangeNotifier {
  final GoalRepository repo = GoalRepository();

  List<GoalModel> goals = [];
  bool isLoading = false;

  GoalViewModel() {
    load();
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();

    goals = await repo.getAll();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addGoal(GoalModel g) async {
    await repo.insert(g);
    await load();
  }

  Future<void> updateGoal(GoalModel g) async {
    if (g.id == null) return;
    await repo.update(g);
    await load();
  }

  Future<void> deleteGoal(int id) async {
    await repo.delete(id);
    await load();
  }

  /// Suma `amount` al campo savedAmount de una meta (útil para "aportar" dinero a la meta)
  Future<void> addToGoal(int goalId, double amount) async {
    final goal = await repo.getById(goalId);
    if (goal == null) return;
    final updated = GoalModel(
      id: goal.id,
      title: goal.title,
      totalAmount: goal.totalAmount,
      savedAmount: goal.savedAmount + amount,
    );
    await repo.update(updated);
    await load();
  }
}
