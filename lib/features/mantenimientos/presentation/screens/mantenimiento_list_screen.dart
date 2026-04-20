// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\mantenimientos\presentation\screens\mantenimiento_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mantenimiento_service.dart';

class MantenimientoListScreen extends StatefulWidget {
  final int vehiculoId;
  const MantenimientoListScreen({super.key, required this.vehiculoId});

  @override
  State<MantenimientoListScreen> createState() => _MantenimientoListScreenState();
}

class _MantenimientoListScreenState extends State<MantenimientoListScreen> {
  List _mantenimientos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final response = await MantenimientoService.getMantenimientos(widget.vehiculoId);
    if (response['success'] == true) {
      if (mounted) setState(() => _mantenimientos = response['data'] ?? []);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mantenimientos')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _mantenimientos.isEmpty
          ? const Center(child: Text('No hay mantenimientos registrados.'))
          : ListView.builder(
              itemCount: _mantenimientos.length,
              itemBuilder: (context, index) {
                final mant = _mantenimientos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.black26,
                  child: ListTile(
                    title: Text(mant['tipo'] ?? ''),
                    subtitle: Text('Fecha: ${mant['fecha']}\nCosto: \$${mant['costo']}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          await context.push('/vehiculo-detail/${widget.vehiculoId}/mantenimientos/form');
          _fetch();
        },
      ),
    );
  }
}




