// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\fincanzas\presentation\screens\gastos_form_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/gastos_service.dart';

class GastosFormScreen extends StatefulWidget {
  final int vehiculoId;
  const GastosFormScreen({super.key, required this.vehiculoId});

  @override
  State<GastosFormScreen> createState() => _GastosFormScreenState();
}

class _GastosFormScreenState extends State<GastosFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _categoriaId;
  final _montoCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  List _categorias = [];
  bool _isLoadingCat = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCats();
  }

  void _fetchCats() async {
    final response = await GastosService.getCategorias();
    if (response['success'] == true && mounted) {
      setState(() {
        _categorias = response['data'] ?? [];
        if (_categorias.isNotEmpty) _categoriaId = _categorias.first['id'];
        _isLoadingCat = false;
      });
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _categoriaId == null) return;
    setState(() => _isLoading = true);
    
    final datos = {
      'vehiculo_id': widget.vehiculoId,
      'categoriaId': _categoriaId,
      'monto': double.tryParse(_montoCtrl.text) ?? 0,
      'descripcion': _descCtrl.text,
    };
    
    final result = await GastosService.crearGasto(datos);
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
      appBar: AppBar(title: const Text('Agregar Gasto')),
      body: _isLoadingCat 
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: _categoriaId,
                items: _categorias.map((c) => DropdownMenuItem<int>(
                  value: c['id'],
                  child: Text(c['nombre'] ?? ''),
                )).toList(),
                onChanged: (val) => setState(() => _categoriaId = val),
                decoration: const InputDecoration(labelText: 'CategorÃ­a'),
              ),
              TextFormField(
                controller: _montoCtrl,
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'DescripciÃ³n'),
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




