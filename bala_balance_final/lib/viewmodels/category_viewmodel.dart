import 'package:flutter/foundation.dart';
import '../data/models/category_model.dart';
import '../data/repositories/category_repository.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository repo = CategoryRepository();

  List<CategoryModel> categories = [];
  bool isLoading = false;

  CategoryViewModel() {
    load();
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();

    categories = await repo.getAll();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel c) async {
    await repo.insert(c);
    await load();
  }

  Future<void> updateCategory(CategoryModel c) async {
    if (c.id == null) return;
    await repo.update(c);
    await load();
  }

  Future<void> deleteCategory(int id) async {
    await repo.delete(id);
    await load();
  }

  String getCategoryName(int categoryId) {
    final category = categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => CategoryModel(id: 0, name: "Ingreso"),
    );
    return category.name;
  }

}
