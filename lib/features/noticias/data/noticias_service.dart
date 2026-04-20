// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\noticias\data\noticias_service.dart
import '../../../core/network/api_service.dart';

class NoticiasService {
  
  static Future<Map<String, dynamic>> getNoticias({int page = 1}) async {
    return await ApiService.get('noticias?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> getNoticiaDetalle(int id) async {
    return await ApiService.get('noticias/detalle?id=$id', withAuth: true);
  }
}




