// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\fincanzas\presentation\screens\combustible_form_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/combustible_service.dart';

class CombustibleFormScreen extends StatefulWidget {
  final int vehiculoId;
  const CombustibleFormScreen({super.key, required this.vehiculoId});

  @override
  State<CombustibleFormScreen> createState() => _CombustibleFormScreenState();
}

class _CombustibleFormScreenState extends State<CombustibleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tipo = 'combustible';
  final _cantidadCtrl = TextEditingController();
  final _unidadCtrl = TextEditingController(text: 'galones');
  final _montoCtrl = TextEditingController();
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final datos = {
      'vehiculo_id': widget.vehiculoId,
      'tipo': _tipo,
      'cantidad': double.tryParse(_cantidadCtrl.text) ?? 1,
      'unidad': _unidadCtrl.text,
      'monto': double.tryParse(_montoCtrl.text) ?? 0,
    };
    
    final result = await CombustibleService.crearCombustible(datos);
    setState(() => _isLoading = false);
    
    if (!mounted) return;
    if (result['success'] == true) {
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _tipo,
                items: const [
                  DropdownMenuItem(value: 'combustible', child: Text('Combustible')),
                  DropdownMenuItem(value: 'aceite', child: Text('Aceite')),
                ],
                onChanged: (val) => setState(() => _tipo = val!),
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
              TextFormField(
                controller: _cantidadCtrl,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _unidadCtrl,
                decoration: const InputDecoration(labelText: 'Unidad (Ej. Galones, Litros)'),
              ),
              TextFormField(
                controller: _montoCtrl,
                decoration: const InputDecoration(labelText: 'Monto Total'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading ? const CircularProgressIndicator() : const Text('GUARDAR'),
              )
            ],
          ),
        ),
      ),
    );
  }
}




