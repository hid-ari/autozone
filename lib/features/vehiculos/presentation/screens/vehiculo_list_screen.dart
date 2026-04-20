// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\vehiculos\presentation\screens\vehiculo_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/vehiculo_provider.dart';
import '../../../../core/utils/image_utils.dart';

class VehiculoListScreen extends StatefulWidget {
  const VehiculoListScreen({super.key});

  @override
  State<VehiculoListScreen> createState() => _VehiculoListScreenState();
}

class _VehiculoListScreenState extends State<VehiculoListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehiculoProvider>().fetchVehiculos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<VehiculoProvider>();

    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (prov.vehiculos.isEmpty) {
      return const Center(child: Text('No tienes vehÃ­culos registrados.'));
    }

    return ListView.builder(
      itemCount: prov.vehiculos.length,
      itemBuilder: (context, index) {
        final vehiculo = prov.vehiculos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.black26,
          child: ListTile(
            leading: vehiculo.fotoUrl != null 
              ? Image.network(ImageUtils.getValidUrl(vehiculo.fotoUrl), width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.directions_car))
              : const Icon(Icons.directions_car, color: Colors.orangeAccent),
            title: Text('${vehiculo.marca} ${vehiculo.modelo} (${vehiculo.anio})'),
            subtitle: Text('Placa: ${vehiculo.placa}'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            onTap: () {
              context.push('/vehiculo-detail/${vehiculo.id}');
            },
          ),
        );
      },
    );
  }
}




