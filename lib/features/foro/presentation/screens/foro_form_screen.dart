// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\foro\presentation\screens\foro_form_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/foro_service.dart';
import '../../../vehiculos/data/vehiculo_service.dart';

class ForoFormScreen extends StatefulWidget {
  const ForoFormScreen({super.key});

  @override
  State<ForoFormScreen> createState() => _ForoFormScreenState();
}

class _ForoFormScreenState extends State<ForoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  List _vehiculos = [];
  int? _vehiculoSeleccionado;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _fetchVehiculos();
  }

  void _fetchVehiculos() async {
    final response = await VehiculoService.getVehiculos();
    if (response['success'] == true && mounted) {
      setState(() {
        _vehiculos = response['data'] ?? [];
        if (_vehiculos.isNotEmpty) {
          _vehiculoSeleccionado = _vehiculos.first['id'];
        }
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _vehiculoSeleccionado == null) {
      if (_vehiculoSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Debe seleccionar un vehÃ­culo')));
      }
      return;
    }
    
    setState(() => _isSaving = true);
    
    final result = await ForoService.crearTema({
      'vehiculo_id': _vehiculoSeleccionado,
      'titulo': _tituloCtrl.text,
      'descripcion': _descCtrl.text,
    });
    
    setState(() => _isSaving = false);
    
    if (!mounted) return;
    if (result['success'] == true) {
      context.pop();
    } else {
      // El API exige que el vehÃ­culo tenga foto para crear tema
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'AsegÃºrate de que tu vehÃ­culo tenga foto.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Consulta en Foro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: _vehiculoSeleccionado,
                items: _vehiculos.map((v) => DropdownMenuItem<int>(
                  value: v['id'],
                  child: Text('${v['marca']} ${v['modelo']}'),
                )).toList(),
                onChanged: (val) => setState(() => _vehiculoSeleccionado = val),
                decoration: const InputDecoration(labelText: 'Selecciona tu VehÃ­culo relacionado'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 16),
                child: Text('Nota: El API requiere que el vehÃ­culo seleccionado posea una foto para crear un tema.', style: TextStyle(color: Colors.amber, fontSize: 12)),
              ),
              TextFormField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(labelText: 'TÃ­tulo del Problema/Consulta'),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'DescripciÃ³n detallada',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  onPressed: _isSaving ? null : _submit,
                  child: _isSaving 
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text('PUBLICAR TEMA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




