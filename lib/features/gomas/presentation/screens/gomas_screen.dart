// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\gomas\presentation\screens\gomas_screen.dart
import 'package:flutter/material.dart';
import '../../data/gomas_service.dart';

class GomasScreen extends StatefulWidget {
  final int vehiculoId;
  const GomasScreen({super.key, required this.vehiculoId});

  @override
  State<GomasScreen> createState() => _GomasScreenState();
}

class _GomasScreenState extends State<GomasScreen> {
  Map<String, dynamic>? _data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final response = await GomasService.getGomas(widget.vehiculoId);
    if (response['success'] == true) {
      if (mounted) setState(() => _data = response['data']);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _actualizar(int gomaId) {
    showDialog(
      context: context,
      builder: (context) {
        String estado = 'buena';
        return AlertDialog(
          title: const Text('Actualizar Estado'),
          content: DropdownButtonFormField<String>(
            value: estado,
            items: const [
              DropdownMenuItem(value: 'buena', child: Text('Buena')),
              DropdownMenuItem(value: 'regular', child: Text('Regular')),
              DropdownMenuItem(value: 'mala', child: Text('Mala')),
              DropdownMenuItem(value: 'reemplazada', child: Text('Reemplazada')),
            ],
            onChanged: (val) => estado = val!,
          ),
          actions: [
            TextButton(child: const Text('Cancelar'), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
              child: const Text('Guardar'),
              onPressed: () async {
                Navigator.pop(context);
                await GomasService.actualizarGoma(gomaId, estado);
                _fetch();
              },
            )
          ],
        );
      }
    );
  }

  void _pinchar(int gomaId) {
     showDialog(
      context: context,
      builder: (context) {
        final ctrl = TextEditingController();
        return AlertDialog(
          title: const Text('Registrar Pinchazo'),
          content: TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'DescripciÃ³n')),
          actions: [
            TextButton(child: const Text('Cancelar'), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
              child: const Text('Guardar'),
              onPressed: () async {
                Navigator.pop(context);
                await GomasService.registrarPinchazo(gomaId, ctrl.text);
                _fetch();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado de Gomas')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _data == null || _data!['gomas'] == null
          ? const Center(child: Text('Sin datos.'))
          : ListView.builder(
              itemCount: (_data!['gomas'] as List).length,
              itemBuilder: (context, index) {
                final goma = _data!['gomas'][index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('${goma['posicion']} - Eje ${goma['eje']}'),
                    subtitle: Text('Estado: ${goma['estado']}\nPinchazos: ${goma['totalPinchazos']}'),
                    isThreeLine: true,
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'actualizar', child: Text('Cambiar Estado')),
                        const PopupMenuItem(value: 'pinchazo', child: Text('Registrar Pinchazo')),
                      ],
                      onSelected: (val) {
                        if (val == 'actualizar') _actualizar(goma['id']);
                        if (val == 'pinchazo') _pinchar(goma['id']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}




