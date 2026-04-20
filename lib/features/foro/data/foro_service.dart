// Hideki Rafael Sarmiento Ariyama 20241453
import '../../../core/network/api_service.dart';

class ForoService {
  static Future<Map<String, dynamic>> getTemas({int page = 1}) async {
    return await ApiService.get('foro/temas?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> getMisTemas({int page = 1}) async {
    return await ApiService.get('foro/mis-temas?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> getDetalleTema(int id) async {
    return await ApiService.get('foro/detalle?id=$id', withAuth: true);
  }

  static Future<Map<String, dynamic>> crearTema(Map<String, dynamic> datos) async {
    return await ApiService.post('foro/crear', datos, withAuth: true);
  }

  static Future<Map<String, dynamic>> responderTema(Map<String, dynamic> datos) async {
    return await ApiService.post('foro/responder', datos, withAuth: true);
  }
}

