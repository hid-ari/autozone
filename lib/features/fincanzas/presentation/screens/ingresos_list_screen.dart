// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\fincanzas\presentation\screens\ingresos_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/ingresos_service.dart';

class IngresosListScreen extends StatefulWidget {
  final int vehiculoId;
  const IngresosListScreen({super.key, required this.vehiculoId});

  @override
  State<IngresosListScreen> createState() => _IngresosListScreenState();
}

class _IngresosListScreenState extends State<IngresosListScreen> {
  List _registros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final response = await IngresosService.getIngresos(widget.vehiculoId);
    if (response['success'] == true) {
      if (mounted) setState(() => _registros = response['data'] ?? []);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos y Ganancias')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _registros.isEmpty
          ? const Center(child: Text('No hay ingresos.'))
          : ListView.builder(
              itemCount: _registros.length,
              itemBuilder: (context, index) {
                final item = _registros[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('${item['concepto']}'),
                    subtitle: Text('Fecha: ${item['fecha']}\nMonto: \$${item['monto']}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await context.push('/vehiculo-detail/${widget.vehiculoId}/ingresos/form');
          _fetch();
        },
      ),
    );
  }
}




