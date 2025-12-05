// Descripción: Pantalla de Registros
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:bala_balance_final/constants/app_colors.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../viewmodels/category_viewmodel.dart';
import '../data/models/transaction_model.dart';
import '../data/models/category_model.dart';

class RegistrosScreen extends StatefulWidget {
  const RegistrosScreen({super.key});

  @override
  State<RegistrosScreen> createState() => _RegistrosScreenState();
}

class _RegistrosScreenState extends State<RegistrosScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<TransactionViewModel>(context, listen: false).load();
      Provider.of<CategoryViewModel>(context, listen: false).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final txVm = Provider.of<TransactionViewModel>(context);
    final catVm = Provider.of<CategoryViewModel>(context);

    final transactions = txVm.transactions;

    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        title: const Text('REGISTROS'),
        centerTitle: true,
        backgroundColor: AppColors.fondo,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                "No hay transacciones registradas",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (_, i) {
                final TransactionModel t = transactions[i];
                final String categoryName =
                    _resolveCategoryName(t, catVm.categories);

                final DateTime parsedDate = _parseDate(t.date);

                return Card(
                  color: AppColors.gris,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          t.type.toLowerCase() == "income" ||
                                  t.type.toLowerCase() == "ingreso"
                              ? AppColors.verde
                              : AppColors.rojo,
                      child: Icon(
                        t.type.toLowerCase() == "income" ||
                                t.type.toLowerCase() == "ingreso"
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      categoryName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_formatDate(parsedDate)),
                    trailing: Text(
                      "S/. ${t.amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: t.type.toLowerCase() == "income" ||
                                t.type.toLowerCase() == "ingreso"
                            ? AppColors.verde
                            : AppColors.rojo,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _resolveCategoryName(
      TransactionModel t, List<CategoryModel> categories) {
    CategoryModel? found;

    for (final c in categories) {
      if (c.id == t.categoryId) {
        found = c;
        break;
      }
    }

    return found?.name ?? "Ingreso";
  }

  DateTime _parseDate(dynamic raw) {
    if (raw == null) return DateTime.now();
    if (raw is DateTime) return raw;

    if (raw is String) {
      try {
        return DateTime.parse(raw);
      } catch (_) {
        try {
          return DateTime.parse(raw.split(" ").first);
        } catch (_) {
          return DateTime.now();
        }
      }
    }

    return DateTime.now();
  }

  String _formatDate(DateTime date) {
    final d = date;
    return "${d.day.toString().padLeft(2, '0')}/"
        "${d.month.toString().padLeft(2, '0')}/"
        "${d.year}";
  }
}
