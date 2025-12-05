// Descripción: AppRouter
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/estadisticas_screen.dart';
import 'screens/metas_screen.dart';
import 'screens/categorias_screen.dart';
import 'screens/registros_screen.dart';
import 'screens/registrar_ingreso_screen.dart';
import 'screens/registrar_egreso_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => HomeScreen(),
    ),
    GoRoute(
      path: '/estadisticas',
      builder: (_, __) => EstadisticasScreen(),
    ),
    GoRoute(
      path: '/metas',
      builder: (_, __) => MetasScreen(),
    ),
    GoRoute(
      path: '/categorias',
      builder: (_, __) => CategoriasScreen(),
    ),
    GoRoute(
      path: '/registros',
      builder: (_, __) => RegistrosScreen(),
    ),
    GoRoute(
      path: '/registrar-ingreso',
      builder: (_, __) => RegistrarIngresoScreen(),
    ),
    GoRoute(
      path: '/registrar-egreso',
      builder: (_, __) => RegistrarEgresoScreen(),
    ),
  ],
);
