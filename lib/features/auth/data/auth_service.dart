// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\features\auth\data\auth_service.dart
import 'package:image_picker/image_picker.dart';
import '../../../core/network/api_service.dart';
import '../domain/models/user.dart';

class AuthService {
  
  static Future<Map<String, dynamic>> login(String matricula, String contrasena) async {
    final response = await ApiService.post('auth/login', {
      'matricula': matricula,
      'contrasena': contrasena,
    });
    return response;
  }

  static Future<Map<String, dynamic>> registro(String matricula) async {
    final response = await ApiService.post('auth/registro', {
      'matricula': matricula,
    });
    return response;
  }

  static Future<Map<String, dynamic>> activar(String token, String contrasena) async {
    final response = await ApiService.post('auth/activar', {
      'token': token,
      'contrasena': contrasena,
    });
    return response;
  }

  static Future<Map<String, dynamic>> olvidar(String matricula) async {
    final response = await ApiService.post('auth/olvidar', {
      'matricula': matricula,
    });
    return response;
  }

  static Future<Map<String, dynamic>> getPerfil() async {
    return await ApiService.get('perfil', withAuth: true);
  }

  static Future<Map<String, dynamic>> updateProfilePhoto(XFile foto) async {
    return await ApiService.postMultipart('perfil/foto', null, withAuth: true, file: foto, fileField: 'foto');
  }

  static Future<Map<String, dynamic>> cambiarClave(String actual, String nueva) async {
    return await ApiService.post('auth/cambiar-clave', {
      'actual': actual,
      'nueva': nueva,
    }, withAuth: true);
  }
}




