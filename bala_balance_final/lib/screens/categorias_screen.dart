// Descripción: Pantalla de Categorias
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:bala_balance_final/constants/app_colors.dart';
import '../viewmodels/category_viewmodel.dart';
import '../data/models/category_model.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryViewModel>(context, listen: false).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final catVm = Provider.of<CategoryViewModel>(context);
    final categories = catVm.categories;

    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        title: const Text("CATEGORIAS"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        backgroundColor: AppColors.fondo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryModal(context),
        backgroundColor: AppColors.gris,
        child: Icon(
          Icons.add,
          color: AppColors.negro,
        ),
      ),
      body: categories.isEmpty
          ? const Center(
              child: Text(
                "No hay categorías registradas",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final CategoryModel c = categories[i];
                return _CategoryCard(c);
              },
            ),
    );
  }

  void _showAddCategoryModal(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Nueva categoría"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gris,
              ),
              child: Text(
                "Guardar",
                style: TextStyle(color: AppColors.negro),
              ),
              onPressed: () {
                final name = nameController.text.trim();

                if (name.isEmpty) return;

                final newCat = CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  name: name
                );

                Provider.of<CategoryViewModel>(context, listen: false)
                    .addCategory(newCat);

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const _CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.fondo,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.gris,
          child: Icon(Icons.folder_open, color: AppColors.negro),
        ),
        title: Text(
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: AppColors.negro,
          ),
        ),
      ),
    );
  }
}
