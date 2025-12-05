// Descripción: Pantalla Home
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:bala_balance_final/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,

      appBar: AppBar(
        title: const Text(
          "BALA-BALANCE",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.gris,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                physics: const NeverScrollableScrollPhysics(),
                children: [

                  _gridButton(context, "ESTADISTICAS", "/estadisticas"),
                  _gridButton(context, "REGISTROS", "/registros"),
                  _gridButton(context, "CATEGORIAS", "/categorias"),
                  _gridButton(context, "METAS", "/metas"),

                ],
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _bottomButton(
                    context,
                    "-",
                    "/registrar-egreso",
                    AppColors.rojo,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _bottomButton(
                    context,
                    "+",
                    "/registrar-ingreso",
                    AppColors.verde,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _gridButton(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gris,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.negro,
              blurRadius: 6,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomButton(
    BuildContext context,
    String text,
    String route,
    Color color,
  ) {
    const double buttonSize = 80;

    return SizedBox(
      height: buttonSize,
      child: ElevatedButton(
        onPressed: () => context.go(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size.fromHeight(buttonSize),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.negro,
          ),
        ),
      ),
    );
  }
}
