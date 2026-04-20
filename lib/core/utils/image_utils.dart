// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es organizar logica y configuraciones del modulo correspondiente.
// Ruta: lib\core\utils\image_utils.dart
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




