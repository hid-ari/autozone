// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\fincanzas\data\combustible_service.dart
import '../../../core/network/api_service.dart';

class CombustibleService {
  static Future<Map<String, dynamic>> getCombustibles(int vehiculoId, {int page = 1}) async {
    return await ApiService.get('combustibles?vehiculo_id=$vehiculoId&page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearCombustible(Map<String, dynamic> datos) async {
    return await ApiService.post('combustibles', datos, withAuth: true);
  }
}




