// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/gastos_service.dart';

class GastosListScreen extends StatefulWidget {
  final int vehiculoId;
  const GastosListScreen({super.key, required this.vehiculoId});

  @override
  State<GastosListScreen> createState() => _GastosListScreenState();
}

class _GastosListScreenState extends State<GastosListScreen> {
  List _gastos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final response = await GastosService.getGastos(widget.vehiculoId);
    if (response['success'] == true) {
      if (mounted) setState(() => _gastos = response['data'] ?? []);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gastos')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _gastos.isEmpty
          ? const Center(child: Text('No hay gastos.'))
          : ListView.builder(
              itemCount: _gastos.length,
              itemBuilder: (context, index) {
                final item = _gastos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('${item['categoriaNombre']}'),
                    subtitle: Text('${item['descripcion'] ?? ''}\nFecha: ${item['fecha']}\nMonto: \$${item['monto']}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await context.push('/vehiculo-detail/${widget.vehiculoId}/gastos/form');
          _fetch();
        },
      ),
    );
  }
}

