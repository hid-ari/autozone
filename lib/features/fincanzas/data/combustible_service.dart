// Hideki Rafael Sarmiento Ariyama 20241453
import '../../../core/network/api_service.dart';

class CombustibleService {
  static Future<Map<String, dynamic>> getCombustibles(int vehiculoId, {int page = 1}) async {
    return await ApiService.get('combustibles?vehiculo_id=$vehiculoId&page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearCombustible(Map<String, dynamic> datos) async {
    return await ApiService.post('combustibles', datos, withAuth: true);
  }
}

