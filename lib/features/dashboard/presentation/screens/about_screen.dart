// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\dashboard\presentation\screens\about_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 60, color: Colors.orangeAccent),
            const SizedBox(height: 16),
            const Text(
              'Desarrollador',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 32),
            _DeveloperCard(
              photoPath: 'assets/foto.jpeg',
              name: 'Hideki Rafael Samiento Ariyama',
              matricula: '20241453',
              phone: '8294101140',
              whatsappUrl: 'https://wa.me/qr/DUEWQSACY6Q7E1',
              email: '20241453@itla.edu.do',
              onCall: () => _launchUrl('tel:8294101140'),
              onWhatsApp: () => _launchUrl('https://wa.me/qr/DUEWQSACY6Q7E1'),
              onEmail: () => _launchUrl('mailto:20241453@itla.edu.do'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Â© 2026 AutoZone ITLA',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeveloperCard extends StatelessWidget {
  final String photoPath;
  final String name;
  final String matricula;
  final String phone;
  final String whatsappUrl;
  final String email;
  final VoidCallback onCall;
  final VoidCallback onWhatsApp;
  final VoidCallback onEmail;

  const _DeveloperCard({
    required this.photoPath,
    required this.name,
    required this.matricula,
    required this.phone,
    required this.whatsappUrl,
    required this.email,
    required this.onCall,
    required this.onWhatsApp,
    required this.onEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orangeAccent,
              child: CircleAvatar(
                radius: 56,
                backgroundImage: AssetImage(photoPath),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'MatrÃ­cula: $matricula',
              style: const TextStyle(fontSize: 16, color: Colors.orangeAccent, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white24),
            const SizedBox(height: 12),
            _ContactTile(
              icon: Icons.phone,
              label: phone,
              onTap: onCall,
            ),
            _ContactTile(
              icon: Icons.chat,
              label: 'WhatsApp',
              onTap: onWhatsApp,
              color: Colors.greenAccent,
            ),
            _ContactTile(
              icon: Icons.email,
              label: email,
              onTap: onEmail,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.orangeAccent),
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
      trailing: const Icon(Icons.open_in_new, size: 18, color: Colors.grey),
      onTap: onTap,
    );
  }
}



