// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\noticias\presentation\screens\noticias_list_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/noticias_service.dart';
import '../../../../core/utils/image_utils.dart';

class NoticiasListScreen extends StatefulWidget {
  const NoticiasListScreen({super.key});

  @override
  State<NoticiasListScreen> createState() => _NoticiasListScreenState();
}

class _NoticiasListScreenState extends State<NoticiasListScreen> {
  List _noticias = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    final response = await NoticiasService.getNoticias(page: 1);
    if (response['success'] == true) {
      if (mounted) setState(() => _noticias = response['data']);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias Automotrices')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _noticias.length,
            itemBuilder: (context, index) {
              final noticia = _noticias[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.black26,
                child: Column(
                  children: [
                    if (noticia['imagenUrl'] != null && noticia['imagenUrl'].toString().isNotEmpty)
                      Image.network(ImageUtils.getValidUrl(noticia['imagenUrl']), height: 200, width: double.infinity, fit: BoxFit.cover),
                    ListTile(
                      title: Text(noticia['titulo'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(noticia['resumen'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                      onTap: () async {
                        if (noticia['link'] != null) {
                          final uri = Uri.parse(noticia['link']);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(noticia['fuente'] ?? ''),
                          Text(noticia['fecha'] ?? '', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
    );
  }
}




