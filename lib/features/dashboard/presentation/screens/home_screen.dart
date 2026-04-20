// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\dashboard\presentation\screens\home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../vehiculos/presentation/screens/vehiculo_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProv = context.watch<AuthProvider>();
    
    // Auth guard logic or splash
    if (authProv.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!authProv.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoZone Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProv.logout();
              context.go('/login');
            },
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[850],
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.orangeAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black,
                    backgroundImage: authProv.user?.fotoUrl != null 
                      ? NetworkImage(ImageUtils.getValidUrl(authProv.user!.fotoUrl))
                      : null,
                    child: authProv.user?.fotoUrl == null 
                      ? const Icon(Icons.account_circle, size: 64, color: Colors.black)
                      : null,
                  ),
                  const SizedBox(height: 8),
                  Text(authProv.user?.nombre ?? 'Usuario', style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(authProv.user?.correo ?? '', style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.orangeAccent),
              title: const Text('Mi Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
                context.push('/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car, color: Colors.orangeAccent),
              title: const Text('Mis VehÃ­culos', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper, color: Colors.orangeAccent),
              title: const Text('Noticias', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
                context.push('/noticias');
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.orangeAccent),
              title: const Text('Videos Educativos', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
                context.push('/videos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.car_rental, color: Colors.orangeAccent),
              title: const Text('CatÃ¡logo de VehÃ­culos', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
                context.push('/catalogo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.forum, color: Colors.orangeAccent),
              title: const Text('Foro de Comunidad', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
                context.push('/foro');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.orangeAccent),
              title: const Text('Acerca de', style: TextStyle(color: Colors.white)),
              onTap: () {
                context.pop();
                context.push('/about');
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Cerrar sesiÃ³n', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                context.pop(); // Close drawer
                authProv.logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
      body: const VehiculoListScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          context.push('/vehiculo-form');
        },
      ),
    );
  }
}




