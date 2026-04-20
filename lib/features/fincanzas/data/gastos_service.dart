// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\fincanzas\data\gastos_service.dart
import '../../../core/network/api_service.dart';

class GastosService {
  static Future<Map<String, dynamic>> getCategorias() async {
    return await ApiService.get('gastos/categorias', withAuth: true);
  }

  static Future<Map<String, dynamic>> getGastos(int vehiculoId, {int page = 1}) async {
    return await ApiService.get('gastos?vehiculo_id=$vehiculoId&page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearGasto(Map<String, dynamic> datos) async {
    return await ApiService.post('gastos', datos, withAuth: true);
  }
}





