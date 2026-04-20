// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\catalogo\presentation\screens\catalogo_detail_screen.dart
import 'package:flutter/material.dart';
import '../../data/catalogo_service.dart';
import '../../../../core/utils/image_utils.dart';

class CatalogoDetailScreen extends StatefulWidget {
  final int autoId;
  const CatalogoDetailScreen({super.key, required this.autoId});

  @override
  State<CatalogoDetailScreen> createState() => _CatalogoDetailScreenState();
}

class _CatalogoDetailScreenState extends State<CatalogoDetailScreen> {
  Map<String, dynamic>? _detalle;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    final response = await CatalogoService.getDetalle(widget.autoId);
    if (response['success'] == true && mounted) {
      setState(() {
        _detalle = response['data'];
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return Scaffold(appBar: AppBar(title: const Text('CatÃ¡logo')), body: const Center(child: CircularProgressIndicator()));
    if (_detalle == null) return Scaffold(appBar: AppBar(title: const Text('CatÃ¡logo')), body: const Center(child: Text('No encontrado')));

    final specs = _detalle!['especificaciones'] as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: Text('${_detalle!['marca']} ${_detalle!['modelo']}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_detalle!['imagenes'] != null && (_detalle!['imagenes'] as List).isNotEmpty)
              Image.network(ImageUtils.getValidUrl(_detalle!['imagenes'][0]), height: 250, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('\$${_detalle!['precio']}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 8),
            Text('${_detalle!['descripcion']}'),
            const Divider(height: 32),
            const Text('Especificaciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (specs != null)
              ...specs.entries.map((e) => ListTile(
                dense: true,
                title: Text(e.key.toString()),
                trailing: Text(e.value.toString()),
              ))
          ],
        ),
      ),
    );
  }
}




