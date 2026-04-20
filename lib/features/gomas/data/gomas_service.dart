// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\gomas\data\gomas_service.dart
import '../../../core/network/api_service.dart';

class GomasService {
  static Future<Map<String, dynamic>> getGomas(int vehiculoId) async {
    return await ApiService.get('gomas?vehiculo_id=$vehiculoId', withAuth: true);
  }

  static Future<Map<String, dynamic>> actualizarGoma(int gomaId, String estado) async {
    return await ApiService.post('gomas/actualizar', {'goma_id': gomaId, 'estado': estado}, withAuth: true);
  }

  static Future<Map<String, dynamic>> registrarPinchazo(int gomaId, String descripcion) async {
    return await ApiService.post('gomas/pinchazos', {'goma_id': gomaId, 'descripcion': descripcion}, withAuth: true);
  }
}




