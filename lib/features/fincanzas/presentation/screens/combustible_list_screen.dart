// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/combustible_service.dart';

class CombustibleListScreen extends StatefulWidget {
  final int vehiculoId;
  const CombustibleListScreen({super.key, required this.vehiculoId});

  @override
  State<CombustibleListScreen> createState() => _CombustibleListScreenState();
}

class _CombustibleListScreenState extends State<CombustibleListScreen> {
  List _registros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final response = await CombustibleService.getCombustibles(widget.vehiculoId);
    if (response['success'] == true) {
      if (mounted) setState(() => _registros = response['data'] ?? []);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Combustibles y Aceites')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _registros.isEmpty
          ? const Center(child: Text('No hay registros.'))
          : ListView.builder(
              itemCount: _registros.length,
              itemBuilder: (context, index) {
                final item = _registros[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('${item['tipo']} - ${item['cantidad']} ${item['unidad']}'),
                    subtitle: Text('Fecha: ${item['fecha']}\nMonto: \$${item['monto']}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await context.push('/vehiculo-detail/${widget.vehiculoId}/combustibles/form');
          _fetch();
        },
      ),
    );
  }
}

