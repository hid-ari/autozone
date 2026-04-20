// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\fincanzas\data\ingresos_service.dart
import '../../../core/network/api_service.dart';

class IngresosService {
  static Future<Map<String, dynamic>> getIngresos(int vehiculoId, {int page = 1}) async {
    return await ApiService.get('ingresos?vehiculo_id=$vehiculoId&page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearIngreso(Map<String, dynamic> datos) async {
    return await ApiService.post('ingresos', datos, withAuth: true);
  }
}




