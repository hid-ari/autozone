// Hideki Rafael Sarmiento Ariyama 20241453
import '../../../core/network/api_service.dart';

class CatalogoService {
  static Future<Map<String, dynamic>> getCatalogo({
    int page = 1,
    String? marca,
    String? modelo,
    int? anio,
    double? precioMin,
    double? precioMax,
    int? limit,
  }) async {
    String url = 'catalogo?page=$page';
    if (marca != null && marca.isNotEmpty) url += '&marca=$marca';
    if (modelo != null && modelo.isNotEmpty) url += '&modelo=$modelo';
    if (anio != null) url += '&anio=$anio';
    if (precioMin != null) url += '&precioMin=$precioMin';
    if (precioMax != null) url += '&precioMax=$precioMax';
    if (limit != null) url += '&limit=$limit';

    return await ApiService.get(url, withAuth: true);
  }

  static Future<Map<String, dynamic>> getDetalle(int id) async {
    return await ApiService.get('catalogo/detalle?id=$id', withAuth: true);
  }
}

