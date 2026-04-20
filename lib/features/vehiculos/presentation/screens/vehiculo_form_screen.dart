// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\vehiculos\presentation\screens\vehiculo_form_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/vehiculo_provider.dart';
import '../../data/vehiculo_service.dart';

class VehiculoFormScreen extends StatefulWidget {
  final Map<String, dynamic>? vehiculoEdit;
  const VehiculoFormScreen({super.key, this.vehiculoEdit});

  @override
  State<VehiculoFormScreen> createState() => _VehiculoFormScreenState();
}

class _VehiculoFormScreenState extends State<VehiculoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _placaCtrl = TextEditingController();
  final _chasisCtrl = TextEditingController();
  final _marcaCtrl = TextEditingController();
  final _modeloCtrl = TextEditingController();
  final _anioCtrl = TextEditingController();
  final _ruedasCtrl = TextEditingController(text: '4');
  bool _isLoading = false;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    if (widget.vehiculoEdit != null) {
      _placaCtrl.text = widget.vehiculoEdit!['placa'];
      _chasisCtrl.text = widget.vehiculoEdit!['chasis'];
      _marcaCtrl.text = widget.vehiculoEdit!['marca'];
      _modeloCtrl.text = widget.vehiculoEdit!['modelo'];
      _anioCtrl.text = widget.vehiculoEdit!['anio'].toString();
      _ruedasCtrl.text = widget.vehiculoEdit!['cantidadRuedas'].toString();
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);

    Map<String, dynamic> datos = {
      'placa': _placaCtrl.text,
      'chasis': _chasisCtrl.text,
      'marca': _marcaCtrl.text,
      'modelo': _modeloCtrl.text,
      'anio': int.tryParse(_anioCtrl.text) ?? 2022,
      'cantidadRuedas': int.tryParse(_ruedasCtrl.text) ?? 4,
    };

    Map<String, dynamic> result;
    if (widget.vehiculoEdit != null) {
      datos['id'] = widget.vehiculoEdit!['id'];
      result = await VehiculoService.editarVehiculo(datos);
    } else {
      result = await VehiculoService.crearVehiculo(datos, foto: _image);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardado exitosamente'), backgroundColor: Colors.green));
      context.read<VehiculoProvider>().fetchVehiculos();
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Error'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.vehiculoEdit == null ? 'Registrar VehÃ­culo' : 'Editar VehÃ­culo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.vehiculoEdit == null) ...[
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.black26,
                    child: _image != null 
                        ? Image.file(File(_image!.path), fit: BoxFit.cover)
                        : const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _marcaCtrl,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _modeloCtrl,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _placaCtrl,
                decoration: const InputDecoration(labelText: 'Placa'),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _chasisCtrl,
                decoration: const InputDecoration(labelText: 'Chasis'),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _anioCtrl,
                decoration: const InputDecoration(labelText: 'AÃ±o'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _ruedasCtrl,
                decoration: const InputDecoration(labelText: 'Cantidad Ruedas'),
                keyboardType: TextInputType.number,
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




