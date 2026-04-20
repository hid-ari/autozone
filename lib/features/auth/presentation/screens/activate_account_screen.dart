// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import '../../data/auth_service.dart';
import 'package:go_router/go_router.dart';

class ActivateAccountScreen extends StatefulWidget {
  const ActivateAccountScreen({super.key});

  @override
  State<ActivateAccountScreen> createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen> {
  final _tokenCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra != null && extra is String) {
      _tokenCtrl.text = extra;
    }
  }

  void _activate() async {
    setState(() => _isLoading = true);
    final result = await AuthService.activar(_tokenCtrl.text.trim(), _contrasenaCtrl.text);
    setState(() => _isLoading = false);

    if (!mounted) return;
    
    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta activada, ahora puedes iniciar sesión.'), backgroundColor: Colors.green),
      );
      context.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Error'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: const Text('Activar Cuenta'), backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tokenCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Token Temporal',
                filled: true,
                fillColor: Colors.black26,
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contrasenaCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nueva Contraseña',
                filled: true,
                fillColor: Colors.black26,
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                onPressed: _isLoading ? null : _activate,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('ACTIVAR', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

