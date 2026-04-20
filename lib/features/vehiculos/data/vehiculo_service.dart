// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\vehiculos\data\vehiculo_service.dart
import 'package:image_picker/image_picker.dart';
import '../../../core/network/api_service.dart';

class VehiculoService {
  static Future<Map<String, dynamic>> getVehiculos({int page = 1}) async {
    return await ApiService.get('vehiculos?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearVehiculo(Map<String, dynamic> datos, {XFile? foto}) async {
    if (foto != null) {
      return await ApiService.postMultipart('vehiculos', datos, withAuth: true, file: foto, fileField: 'foto');
    }
    return await ApiService.post('vehiculos', datos, withAuth: true);
  }

  static Future<Map<String, dynamic>> editarVehiculo(Map<String, dynamic> datos) async {
    return await ApiService.post('vehiculos/editar', datos, withAuth: true);
  }

  static Future<Map<String, dynamic>> getDetalleVehiculo(int id) async {
    return await ApiService.get('vehiculos/detalle?id=$id', withAuth: true);
  }
}




