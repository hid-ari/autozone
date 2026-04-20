// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\videos\data\videos_service.dart
import '../../../core/network/api_service.dart';

class VideosService {
  
  static Future<Map<String, dynamic>> getVideos() async {
    return await ApiService.get('videos', withAuth: true);
  }
}




