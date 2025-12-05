// Descripción: Pantalla de Metas
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/goal_viewmodel.dart';
import '../../data/models/goal_model.dart';
import 'package:go_router/go_router.dart';
import 'package:bala_balance_final/constants/app_colors.dart';

class MetasScreen extends StatelessWidget {
  const MetasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: AppColors.fondo,
          appBar: AppBar(
            title: const Text("METAS"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
            ),
            backgroundColor: AppColors.fondo,
          ),

          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : vm.goals.isEmpty
                  ? const Center(child: Text("No tienes metas aún"))
                  : ListView.builder(
                      itemCount: vm.goals.length,
                      itemBuilder: (context, index) {
                        final g = vm.goals[index];
                        final progress =
                            (g.savedAmount / g.totalAmount).clamp(0.0, 1.0);

                        return Card(
                          color: AppColors.gris,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: ListTile(
                            title: Text(g.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "S/. ${g.savedAmount.toStringAsFixed(2)} / "
                                  "S/. ${g.totalAmount.toStringAsFixed(2)}",
                                ),
                                const SizedBox(height: 6),
                                LinearProgressIndicator(value: progress, color: AppColors.verde,),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) async {
                                if (value == "edit") {
                                  _showCreateOrEditDialog(context, vm, g);
                                } else if (value == "add") {
                                  _showAddMoneyDialog(context, vm, g);
                                } else if (value == "delete") {
                                  if (g.id != null) vm.deleteGoal(g.id!);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: "add",
                                    child: Text("Aportar dinero")),
                                const PopupMenuItem(
                                    value: "edit", child: Text("Editar")),
                                const PopupMenuItem(
                                    value: "delete", child: Text("Eliminar")),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateOrEditDialog(context, vm, null),
            backgroundColor: AppColors.gris,
            child: Icon(Icons.add, color: AppColors.negro,),
          ),
        );
      },
    );
  }

  // CREAR META
  void _showCreateOrEditDialog(
      BuildContext context, GoalViewModel vm, GoalModel? goal) {
    final titleCtrl = TextEditingController(text: goal?.title ?? "");
    final amountCtrl = TextEditingController(
        text: goal?.totalAmount.toString() ?? "");

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(goal == null ? "Nueva Meta" : "Editar Meta"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Monto total (S/.)"),
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
              child: Text("Guardar", style: TextStyle(color: AppColors.negro)),
              onPressed: () async {
                final title = titleCtrl.text.trim();
                final total = double.tryParse(amountCtrl.text) ?? 0;

                if (title.isEmpty || total <= 0) return;

                if (goal == null) {
                  await vm.addGoal(
                    GoalModel(
                      title: title,
                      totalAmount: total,
                      savedAmount: 0,
                    ),
                  );
                } else {
                  await vm.updateGoal(
                    GoalModel(
                      id: goal.id,
                      title: title,
                      totalAmount: total,
                      savedAmount: goal.savedAmount,
                    ),
                  );
                }

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // APORTAR
  void _showAddMoneyDialog(
      BuildContext context, GoalViewModel vm, GoalModel goal) {
    final amountCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Aportar a ${goal.title}"),
          content: TextField(
            controller: amountCtrl,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: "Monto a aportar (S/.)"),
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
              child: Text("Aportar", style: TextStyle(color: AppColors.negro)),
              onPressed: () async {
                final amount = double.tryParse(amountCtrl.text) ?? 0;
                if (amount <= 0) return;

                await vm.addToGoal(goal.id!, amount);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
