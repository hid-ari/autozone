// Hideki Rafael Sarmiento Ariyama 20241453
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../data/mantenimiento_service.dart';

class MantenimientoFormScreen extends StatefulWidget {
  final int vehiculoId;
  const MantenimientoFormScreen({super.key, required this.vehiculoId});

  @override
  State<MantenimientoFormScreen> createState() => _MantenimientoFormScreenState();
}

class _MantenimientoFormScreenState extends State<MantenimientoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tipoCtrl = TextEditingController();
  final _costoCtrl = TextEditingController();
  final _piezasCtrl = TextEditingController();
  final _fechaCtrl = TextEditingController();
  
  bool _isLoading = false;
  List<XFile>? _fotos;

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _fotos = images;
      });
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);

    Map<String, dynamic> datos = {
      'vehiculo_id': widget.vehiculoId,
      'tipo': _tipoCtrl.text,
      'costo': double.tryParse(_costoCtrl.text) ?? 0,
      'piezas': _piezasCtrl.text,
      'fecha': _fechaCtrl.text.isEmpty ? DateTime.now().toIso8601String().split('T')[0] : _fechaCtrl.text,
    };

    final result = await MantenimientoService.crearMantenimiento(datos, fotos: _fotos);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardado exitosamente'), backgroundColor: Colors.green));
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Error'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completar Mantenimiento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tipoCtrl,
                decoration: const InputDecoration(labelText: 'Tipo (Ej. Cambio aceite)'),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _costoCtrl,
                decoration: const InputDecoration(labelText: 'Costo'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _piezasCtrl,
                decoration: const InputDecoration(labelText: 'Piezas (Opcional)'),
              ),
              TextFormField(
                controller: _fechaCtrl,
                decoration: const InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.photo_library),
                label: Text(_fotos == null || _fotos!.isEmpty ? 'Adjuntar Fotos' : '${_fotos!.length} fotos seleccionadas'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text('GUARDAR', style: TextStyle(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

