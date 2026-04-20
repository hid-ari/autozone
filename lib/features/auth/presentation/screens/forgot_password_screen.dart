// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import '../../data/auth_service.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _matriculaCtrl = TextEditingController();
  bool _isLoading = false;

  void _generateTempPassword() async {
    setState(() => _isLoading = true);
    final result = await AuthService.olvidar(_matriculaCtrl.text.trim());
    setState(() => _isLoading = false);

    if (!mounted) return;
    
    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Clave temporal asignada (123456). Usa esto para ingresar y luego cámbiala.'), backgroundColor: Colors.green),
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
      appBar: AppBar(title: const Text('Recuperar contraseña'), backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingresa tu matrícula', style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: _matriculaCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Matrícula',
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
                onPressed: _isLoading ? null : _generateTempPassword,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('RECUPERAR', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

