// Hideki Rafael Sarmiento Ariyama 20241453
import '../../../core/network/api_service.dart';

class IngresosService {
  static Future<Map<String, dynamic>> getIngresos(int vehiculoId, {int page = 1}) async {
    return await ApiService.get('ingresos?vehiculo_id=$vehiculoId&page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearIngreso(Map<String, dynamic> datos) async {
    return await ApiService.post('ingresos', datos, withAuth: true);
  }
}

