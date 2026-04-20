// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/ingresos_service.dart';

class IngresosFormScreen extends StatefulWidget {
  final int vehiculoId;
  const IngresosFormScreen({super.key, required this.vehiculoId});

  @override
  State<IngresosFormScreen> createState() => _IngresosFormScreenState();
}

class _IngresosFormScreenState extends State<IngresosFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _conceptoCtrl = TextEditingController();
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final datos = {
      'vehiculo_id': widget.vehiculoId,
      'monto': double.tryParse(_montoCtrl.text) ?? 0,
      'concepto': _conceptoCtrl.text,
    };
    
    final result = await IngresosService.crearIngreso(datos);
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
      appBar: AppBar(title: const Text('Agregar Ingreso')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _conceptoCtrl,
                decoration: const InputDecoration(labelText: 'Concepto'),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _montoCtrl,
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
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

