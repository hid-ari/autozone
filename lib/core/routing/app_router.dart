// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es organizar logica y configuraciones del modulo correspondiente.
// Ruta: lib\core\routing\app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/activate_account_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/profile_screen.dart';
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/dashboard/presentation/screens/about_screen.dart';
import '../../features/vehiculos/presentation/screens/vehiculo_form_screen.dart';
import '../../features/vehiculos/presentation/screens/vehiculo_detail_screen.dart';
import '../../features/noticias/presentation/screens/noticias_list_screen.dart';
import '../../features/mantenimientos/presentation/screens/mantenimiento_list_screen.dart';
import '../../features/mantenimientos/presentation/screens/mantenimiento_form_screen.dart';
import '../../features/fincanzas/presentation/screens/combustible_list_screen.dart';
import '../../features/fincanzas/presentation/screens/combustible_form_screen.dart';
import '../../features/fincanzas/presentation/screens/gastos_list_screen.dart';
import '../../features/fincanzas/presentation/screens/gastos_form_screen.dart';
import '../../features/fincanzas/presentation/screens/ingresos_list_screen.dart';
import '../../features/fincanzas/presentation/screens/ingresos_form_screen.dart';
import '../../features/gomas/presentation/screens/gomas_screen.dart';
import '../../features/videos/presentation/screens/videos_list_screen.dart';
import '../../features/catalogo/presentation/screens/catalogo_list_screen.dart';
import '../../features/catalogo/presentation/screens/catalogo_detail_screen.dart';
import '../../features/foro/presentation/screens/foro_list_screen.dart';
import '../../features/foro/presentation/screens/foro_detail_screen.dart';
import '../../features/foro/presentation/screens/foro_form_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/activate',
      builder: (context, state) => const ActivateAccountScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/vehiculo-form',
      builder: (context, state) => VehiculoFormScreen(vehiculoEdit: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(
      path: '/vehiculo-detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return VehiculoDetailScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/noticias',
      builder: (context, state) => const NoticiasListScreen(),
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/mantenimientos',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return MantenimientoListScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/mantenimientos/form',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return MantenimientoFormScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/combustibles',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CombustibleListScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/combustibles/form',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CombustibleFormScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/gastos',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return GastosListScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/gastos/form',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return GastosFormScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/ingresos',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return IngresosListScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/ingresos/form',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return IngresosFormScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/vehiculo-detail/:id/gomas',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return GomasScreen(vehiculoId: id);
      },
    ),
    GoRoute(
      path: '/videos',
      builder: (context, state) => const VideosListScreen(),
    ),
    GoRoute(
      path: '/catalogo',
      builder: (context, state) => const CatalogoListScreen(),
    ),
    GoRoute(
      path: '/catalogo-detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CatalogoDetailScreen(autoId: id);
      },
    ),
    GoRoute(
      path: '/foro',
      builder: (context, state) => const ForoListScreen(),
    ),
    GoRoute(
      path: '/foro-form',
      builder: (context, state) => const ForoFormScreen(),
    ),
    GoRoute(
      path: '/foro-detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ForoDetailScreen(temaId: id);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);




