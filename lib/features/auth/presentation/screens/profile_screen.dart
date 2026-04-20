// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\auth\presentation\screens\profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/auth_provider.dart';
import '../../../../core/utils/image_utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _changePhoto(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        await context.read<AuthProvider>().updateProfilePhoto(image);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto de perfil actualizada')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _showActivateDialog(BuildContext context) async {
    final actualPassCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final authProv = context.read<AuthProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Cambiar ContraseÃ±a', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ingresa tu contraseÃ±a actual y la nueva contraseÃ±a para actualizarla.', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 16),
              TextField(
                controller: actualPassCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'ContraseÃ±a Actual', labelStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Nueva ContraseÃ±a', labelStyle: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('CANCELAR')),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('GUARDAR', style: TextStyle(color: Colors.orangeAccent)),
            ),
          ],
        );
      },
    );

    if (confirm == true && context.mounted) {
      if (passCtrl.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La nueva contraseÃ±a debe tener al menos 6 caracteres'), backgroundColor: Colors.red),
        );
        return;
      }
      try {
        await authProv.cambiarClave(actualPassCtrl.text, passCtrl.text);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ContraseÃ±a actualizada con Ã©xito'), backgroundColor: Colors.green),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProv = context.watch<AuthProvider>();
    final user = authProv.user;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('No has iniciado sesiÃ³n')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.orangeAccent,
                  backgroundImage: user.fotoUrl != null
                      ? NetworkImage(ImageUtils.getValidUrl(user.fotoUrl))
                      : null,
                  child: user.fotoUrl == null
                      ? const Icon(Icons.person, size: 70, color: Colors.black)
                      : null,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orangeAccent,
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 20, color: Colors.black),
                    onPressed: () => _changePhoto(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '${user.nombre} ${user.apellido}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              user.correo,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Divider(),
            _ProfileItem(
              icon: Icons.badge,
              label: 'MatrÃ­cula',
              value: user.matricula ?? 'N/A',
            ),
            _ProfileItem(
              icon: Icons.admin_panel_settings,
              label: 'Rol',
              value: user.rol ?? 'Usuario',
            ),
            _ProfileItem(
              icon: Icons.group,
              label: 'Grupo',
              value: user.grupo ?? 'Sin grupo',
            ),
            _ProfileItem(
              icon: Icons.calendar_today,
              label: 'Fecha de Registro',
              value: user.fechaRegistro ?? 'N/A',
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.password, color: Colors.orangeAccent),
              title: const Text('Cambiar ContraseÃ±a', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Actualiza tu contraseÃ±a actual', style: TextStyle(color: Colors.white54, fontSize: 12)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
              onTap: () => _showActivateDialog(context),
            ),
            const SizedBox(height: 48),
            if (authProv.isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(label),
      subtitle: Text(value, style: const TextStyle(color: Colors.white70)),
    );
  }
}




