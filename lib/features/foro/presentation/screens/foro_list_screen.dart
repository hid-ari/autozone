// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es definir la interfaz de usuario y la interaccion de pantalla.
// Ruta: lib\features\foro\presentation\screens\foro_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/foro_service.dart';
import '../../../../core/utils/image_utils.dart';

class ForoListScreen extends StatefulWidget {
  const ForoListScreen({super.key});

  @override
  State<ForoListScreen> createState() => _ForoListScreenState();
}

class _ForoListScreenState extends State<ForoListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List _temasGlobales = [];
  List _misTemas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetch();
  }

  void _fetch() async {
    setState(() => _isLoading = true);
    final res1 = await ForoService.getTemas();
    final res2 = await ForoService.getMisTemas();
    if (mounted) {
      if (res1['success'] == true) _temasGlobales = res1['data'] ?? [];
      if (res2['success'] == true) _misTemas = res2['data'] ?? [];
      setState(() => _isLoading = false);
    }
  }

  Widget _buildList(List items) {
    if (items.isEmpty) return const Center(child: Text('No hay temas en el foro.'));
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final tema = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.black26,
          child: ListTile(
            leading: tema['vehiculoFoto'] != null
               ? Image.network(ImageUtils.getValidUrl(tema['vehiculoFoto']), width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.forum))
               : const Icon(Icons.forum, color: Colors.orangeAccent),
            title: Text(tema['titulo'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${tema['autor'] ?? ''} - Respuestas: ${tema['totalRespuestas'] ?? 0}'),
            onTap: () {
              context.push('/foro-detail/${tema['id']}');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foro de Comunidad'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todos los Temas'),
            Tab(text: 'Mis Temas'),
          ],
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: [
              _buildList(_temasGlobales),
              _buildList(_misTemas),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await context.push('/foro-form');
          _fetch();
        },
      ),
    );
  }
}




