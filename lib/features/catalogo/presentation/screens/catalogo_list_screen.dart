// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\catalogo\presentation\screens\catalogo_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/catalogo_service.dart';
import '../../../../core/utils/image_utils.dart';

class CatalogoListScreen extends StatefulWidget {
  const CatalogoListScreen({super.key});

  @override
  State<CatalogoListScreen> createState() => _CatalogoListScreenState();
}

class _CatalogoListScreenState extends State<CatalogoListScreen> {
  List _items = [];
  bool _isLoading = true;

  String? _marca;
  String? _modelo;
  int? _anio;
  double? _precioMin;
  double? _precioMax;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final response = await CatalogoService.getCatalogo(
      page: 1,
      marca: _marca,
      modelo: _modelo,
      anio: _anio,
      precioMin: _precioMin,
      precioMax: _precioMax,
    );
    if (response['success'] == true && mounted) {
      setState(() {
        _items = response['data'] ?? [];
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showFilterDialog() {
    final marcaCtrl = TextEditingController(text: _marca);
    final modeloCtrl = TextEditingController(text: _modelo);
    final anioCtrl = TextEditingController(text: _anio?.toString() ?? '');
    final minCtrl = TextEditingController(text: _precioMin?.toString() ?? '');
    final maxCtrl = TextEditingController(text: _precioMax?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Filtrar CatÃ¡logo', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: marcaCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'Marca', labelStyle: TextStyle(color: Colors.white70))),
                TextField(controller: modeloCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'Modelo', labelStyle: TextStyle(color: Colors.white70))),
                TextField(controller: anioCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'AÃ±o', labelStyle: TextStyle(color: Colors.white70)), keyboardType: TextInputType.number),
                TextField(controller: minCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'Precio MÃ­nimo', labelStyle: TextStyle(color: Colors.white70)), keyboardType: TextInputType.number),
                TextField(controller: maxCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'Precio MÃ¡ximo', labelStyle: TextStyle(color: Colors.white70)), keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _marca = null; _modelo = null; _anio = null; _precioMin = null; _precioMax = null;
                });
                Navigator.pop(context);
                _fetch();
              },
              child: const Text('Limpiar', style: TextStyle(color: Colors.redAccent)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _marca = marcaCtrl.text.isNotEmpty ? marcaCtrl.text : null;
                  _modelo = modeloCtrl.text.isNotEmpty ? modeloCtrl.text : null;
                  _anio = int.tryParse(anioCtrl.text);
                  _precioMin = double.tryParse(minCtrl.text);
                  _precioMax = double.tryParse(maxCtrl.text);
                });
                Navigator.pop(context);
                _fetch();
              },
              child: const Text('Aplicar', style: TextStyle(color: Colors.orangeAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatÃ¡logo de VehÃ­culos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          )
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final auto = _items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.black26,
                child: ListTile(
                  leading: auto['imagenUrl'] != null 
                    ? Image.network(ImageUtils.getValidUrl(auto['imagenUrl']), width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.car_rental, color: Colors.orangeAccent))
                    : const Icon(Icons.car_rental, color: Colors.orangeAccent),
                  title: Text('${auto['marca']} ${auto['modelo']}', style: const TextStyle(color: Colors.white)),
                  subtitle: Text('AÃ±o: ${auto['anio']} - \$${auto['precio']}', style: const TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orangeAccent),
                  onTap: () {
                    context.push('/catalogo-detail/${auto['id']}');
                  },
                ),
              );
            },
          ),
    );
  }
}




