// Descripción: Main de la aplicación
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/transaction_viewmodel.dart';
import 'viewmodels/category_viewmodel.dart';
import 'viewmodels/goal_viewmodel.dart';
import 'app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoalViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
