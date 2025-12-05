// Descripción: Pantalla de Registrar Ingreso
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:bala_balance_final/constants/app_colors.dart';
import '../data/models/transaction_model.dart';
import '../viewmodels/transaction_viewmodel.dart';

class RegistrarIngresoScreen extends StatefulWidget {
  const RegistrarIngresoScreen({super.key});

  @override
  State<RegistrarIngresoScreen> createState() => _RegistrarIngresoScreenState();
}

class _RegistrarIngresoScreenState extends State<RegistrarIngresoScreen> {
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.verde,
              onPrimary: AppColors.negro,
              surface: AppColors.fondo,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void saveTransaction() async {
    if (amountCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa un monto")),
      );
      return;
    }

    final vm = Provider.of<TransactionViewModel>(context, listen: false);

    final transaction = TransactionModel(
      amount: double.parse(amountCtrl.text),
      type: "income",
      categoryId: 0,
      description: descriptionCtrl.text,
      date: _selectedDate.toIso8601String(),
    );

    await vm.addTransaction(transaction);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ingreso registrado")),
    );

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        title: const Text("REGISTRAR INGRESO"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        backgroundColor: AppColors.fondo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Monto",
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.verde, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionCtrl,
              decoration: InputDecoration(
                labelText: "Descripción (opcional)",
                border: const OutlineInputBorder(),
                 focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.verde, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fecha: ${_selectedDate.toLocal().toString().split(' ')[0]}",
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: pickDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.verde,
                  ),
                  child: Text(
                    "Seleccionar",
                    style: TextStyle(color: AppColors.negro),
                  ),
                ),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.verde,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  "Guardar Ingreso",
                  style: TextStyle(
                    color: AppColors.negro,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
