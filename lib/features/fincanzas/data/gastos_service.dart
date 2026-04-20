// Hideki Rafael Sarmiento Ariyama 20241453
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


