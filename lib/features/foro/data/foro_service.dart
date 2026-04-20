// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\foro\data\foro_service.dart
import '../../../core/network/api_service.dart';

class ForoService {
  
  static Future<Map<String, dynamic>> getTemas({int page = 1}) async {
    return await ApiService.get('foro/temas?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> getMisTemas({int page = 1}) async {
    return await ApiService.get('foro/mis-temas?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> getDetalleTema(int id) async {
    return await ApiService.get('foro/detalle?id=$id', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearTema(Map<String, dynamic> datos) async {
    return await ApiService.post('foro/crear', datos, withAuth: true);
  }

  static Future<Map<String, dynamic>> responderTema(Map<String, dynamic> datos) async {
    return await ApiService.post('foro/responder', datos, withAuth: true);
  }
}




