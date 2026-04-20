// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import '../../data/vehiculo_service.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/image_utils.dart';

class VehiculoDetailScreen extends StatefulWidget {
  final int vehiculoId;
  const VehiculoDetailScreen({super.key, required this.vehiculoId});

  @override
  State<VehiculoDetailScreen> createState() => _VehiculoDetailScreenState();
}

class _VehiculoDetailScreenState extends State<VehiculoDetailScreen> {
  Map<String, dynamic>? _detalle;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  void _fetchDetail() async {
    final response = await VehiculoService.getDetalleVehiculo(widget.vehiculoId);
    if (response['success'] == true) {
      if (mounted) setState(() => _detalle = response['data']);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Vehículo')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _detalle == null 
          ? const Center(child: Text('No se pudo cargar el detalle'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_detalle!['fotoUrl'] != null)
                  Image.network(ImageUtils.getValidUrl(_detalle!['fotoUrl']), height: 200, fit: BoxFit.cover),
                const SizedBox(height: 16),
                Text('${_detalle!['marca']} ${_detalle!['modelo']} (${_detalle!['anio']})', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Placa: ${_detalle!['placa']}'),
                Text('Chasis: ${_detalle!['chasis']}'),
                const Divider(height: 32),
                const Text('Resumen Financiero', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                if (_detalle!['resumen'] != null) ...[
                   ListTile(title: const Text('Total Mantenimientos'), trailing: Text('\$${_detalle!['resumen']['totalMantenimientos']}')),
                   ListTile(title: const Text('Total Combustible'), trailing: Text('\$${_detalle!['resumen']['totalCombustible']}')),
                   ListTile(title: const Text('Gastos Extras'), trailing: Text('\$${_detalle!['resumen']['totalGastos']}')),
                   ListTile(title: const Text('Ingresos'), trailing: Text('\$${_detalle!['resumen']['totalIngresos']}', style: const TextStyle(color: Colors.green))),
                   ListTile(title: const Text('Balance Final'), trailing: Text('\$${_detalle!['resumen']['balance']}', style: TextStyle(fontWeight: FontWeight.bold, color: (_detalle!['resumen']['balance'] ?? 0) >= 0 ? Colors.green : Colors.red))),
                ],
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.build),
                      label: const Text('Mantenimientos'),
                      onPressed: () => context.push('/vehiculo-detail/${widget.vehiculoId}/mantenimientos'),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.local_gas_station),
                      label: const Text('Combustibles'),
                      onPressed: () => context.push('/vehiculo-detail/${widget.vehiculoId}/combustibles'),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.money_off),
                      label: const Text('Gastos'),
                      onPressed: () => context.push('/vehiculo-detail/${widget.vehiculoId}/gastos'),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.attach_money),
                      label: const Text('Ingresos'),
                      onPressed: () => context.push('/vehiculo-detail/${widget.vehiculoId}/ingresos'),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.tire_repair),
                      label: const Text('Gomas'),
                      onPressed: () => context.push('/vehiculo-detail/${widget.vehiculoId}/gomas'),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

