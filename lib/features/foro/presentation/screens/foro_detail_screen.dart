// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\foro\presentation\screens\foro_detail_screen.dart
import 'package:flutter/material.dart';
import '../../data/foro_service.dart';
import '../../../../core/utils/image_utils.dart';

class ForoDetailScreen extends StatefulWidget {
  final int temaId;
  const ForoDetailScreen({super.key, required this.temaId});

  @override
  State<ForoDetailScreen> createState() => _ForoDetailScreenState();
}

class _ForoDetailScreenState extends State<ForoDetailScreen> {
  Map<String, dynamic>? _tema;
  bool _isLoading = true;
  final _respuestaCtrl = TextEditingController();
  bool _isReplying = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    final response = await ForoService.getDetalleTema(widget.temaId);
    if (response['success'] == true && mounted) {
      setState(() {
        _tema = response['data'];
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _enviarRespuesta() async {
    if (_respuestaCtrl.text.isEmpty) return;
    setState(() => _isReplying = true);
    
    final result = await ForoService.responderTema({
      'tema_id': widget.temaId,
      'contenido': _respuestaCtrl.text,
    });
    
    if (mounted) {
      setState(() => _isReplying = false);
      if (result['success'] == true) {
        _respuestaCtrl.clear();
        _fetch(); // Refrescar tema
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Error al responder')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_tema == null) return const Scaffold(body: Center(child: Text('Tema no encontrado')));

    final respuestas = _tema!['respuestas'] as List? ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Tema en DiscusiÃ³n')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(_tema!['titulo'] ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                const SizedBox(height: 8),
                Text('Por: ${_tema!['autor'] ?? ''} - ${_tema!['fecha']}'),
                const SizedBox(height: 16),
                if (_tema!['vehiculoFoto'] != null)
                  Image.network(ImageUtils.getValidUrl(_tema!['vehiculoFoto']), height: 200, fit: BoxFit.cover),
                const SizedBox(height: 16),
                Text(_tema!['descripcion'] ?? '', style: const TextStyle(fontSize: 16)),
                const Divider(height: 48, thickness: 2),
                const Text('Respuestas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                if (respuestas.isEmpty)
                  const Padding(padding: EdgeInsets.only(top: 16), child: Text('Se el primero en responder.'))
                else
                  ...respuestas.map((r) => Card(
                    color: Colors.black26,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['autor'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                          const SizedBox(height: 4),
                          Text(r['contenido'] ?? ''),
                          const SizedBox(height: 8),
                          Text(r['fecha'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[900],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _respuestaCtrl,
                    decoration: const InputDecoration(
                      hintText: 'AÃ±adir una respuesta...',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _isReplying 
                  ? const CircularProgressIndicator()
                  : IconButton(
                      icon: const Icon(Icons.send, color: Colors.orangeAccent),
                      onPressed: _enviarRespuesta,
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




