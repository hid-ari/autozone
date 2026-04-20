// Hideki Rafael Sarmiento Ariyama 20241453
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

