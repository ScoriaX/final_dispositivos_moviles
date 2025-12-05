// Descripción: Pantalla de Estadisticas
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:bala_balance_final/constants/app_colors.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../viewmodels/category_viewmodel.dart';

class EstadisticasScreen extends StatelessWidget {
  const EstadisticasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final txVm = Provider.of<TransactionViewModel>(context);
    final catVm = Provider.of<CategoryViewModel>(context);

    final transactions = txVm.transactions;

    if (catVm.isLoading) {
      return Scaffold(
        backgroundColor: AppColors.fondo,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    double totalIngresos = 0;
    for (var t in transactions) {
      final tipo = t.type.toLowerCase().trim();
      if (tipo == "ingreso" || t.categoryId == 0) {
        totalIngresos += t.amount;
      }
    }

    final egresos = <int, double>{};

    for (var t in transactions) {
      final tipo = t.type.toLowerCase().trim();

      if (t.categoryId == 0 || tipo == "ingreso") continue;

      egresos[t.categoryId!] =
          (egresos[t.categoryId!] ?? 0) + t.amount;
    }

    if (egresos.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.fondo,
        appBar: AppBar(
          title: const Text("ESTADISTICAS"),
          backgroundColor: AppColors.fondo,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: Center(
          child: Text(
            "Ingresos: S/. ${totalIngresos.toStringAsFixed(2)}\n\nNo hay egresos registrados",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    final sections = <PieChartSectionData>[];
    int i = 0;

    egresos.forEach((catId, amount) {
      final name = catVm.getCategoryName(catId);

      sections.add(
        PieChartSectionData(
          value: amount,
          radius: 100,
          title: name,
          color: Colors.primaries[i % Colors.primaries.length],
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      i++;
    });

    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        title: const Text("ESTADISTICAS"),
        backgroundColor: AppColors.fondo,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 80,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
