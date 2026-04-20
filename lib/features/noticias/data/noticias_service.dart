// Hideki Rafael Sarmiento Ariyama 20241453
import '../../../core/network/api_service.dart';

class NoticiasService {
  static Future<Map<String, dynamic>> getNoticias({int page = 1}) async {
    return await ApiService.get('noticias?page=$page', withAuth: true);
  }

  static Future<Map<String, dynamic>> getNoticiaDetalle(int id) async {
    return await ApiService.get('noticias/detalle?id=$id', withAuth: true);
  }
}

