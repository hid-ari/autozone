// Hideki Rafael Sarmiento Ariyama 20241453
import '../../../core/network/api_service.dart';

class VideosService {
  static Future<Map<String, dynamic>> getVideos() async {
    return await ApiService.get('videos', withAuth: true);
  }
}

