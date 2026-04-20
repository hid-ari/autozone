// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:image_picker/image_picker.dart';
import '../../../core/network/api_service.dart';

class MantenimientoService {
  static Future<Map<String, dynamic>> getMantenimientos(int vehiculoId, {int page = 1}) async {
    return await ApiService.get('mantenimientos?vehiculo_id=$vehiculoId&page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearMantenimiento(Map<String, dynamic> datos, {List<XFile>? fotos}) async {
    if (fotos != null && fotos.isNotEmpty) {
      return await ApiService.postMultipart(
        'mantenimientos', 
        datos, 
        withAuth: true, 
        files: fotos, 
        filesField: 'fotos[]'
      );
    }
    return await ApiService.post('mantenimientos', datos, withAuth: true);
  }

  static Future<Map<String, dynamic>> getDetalle(int id) async {
    return await ApiService.get('mantenimientos/detalle?id=$id', withAuth: true);
  }
}

