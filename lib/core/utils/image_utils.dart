// Hideki Rafael Sarmiento Ariyama 20241453
class ImageUtils {
  static String getValidUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    if (url.startsWith('https://')) {
      return url;
    }
    return 'https://taller-itla.ia3x.com/api/imagen?path=$url';
  }
}

