// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\mantenimientos\data\mantenimiento_service.dart
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




