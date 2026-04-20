// Documentacion del archivo.
// Este archivo pertenece a la capa de aplicacion y su objetivo principal es concentrar la comunicacion con la API y operaciones de red.
// Ruta: lib\core\network\api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<Map<String, String>> _getHeaders({bool withAuth = false}) async {
    final headers = <String, String>{};
    if (withAuth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  static Future<Map<String, dynamic>> get(String endpoint, {bool withAuth = false, Map<String, String>? queryParams}) async {
    try {
      var uri = Uri.parse('${ApiConstants.baseUrl}/$endpoint');
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }
      final headers = await _getHeaders(withAuth: withAuth);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body); // Usually contains success: false and message
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data, {bool withAuth = false}) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}/$endpoint');
      final headers = await _getHeaders(withAuth: withAuth);
      
      final response = await http.post(
        uri,
        headers: headers,
        body: {'datax': jsonEncode(data)},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> postMultipart(
    String endpoint,
    Map<String, dynamic>? data, {
    bool withAuth = false,
    XFile? file,
    String fileField = 'foto',
    List<XFile>? files,
    String filesField = 'fotos[]',
  }) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}/$endpoint');
      final request = http.MultipartRequest('POST', uri);
      
      final headers = await _getHeaders(withAuth: withAuth);
      request.headers.addAll(headers);
      
      if (data != null && data.isNotEmpty) {
        request.fields['datax'] = jsonEncode(data);
      }

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(fileField, file.path));
      }

      if (files != null) {
        for (var f in files) {
          request.files.add(await http.MultipartFile.fromPath(filesField, f.path));
        }
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      return jsonDecode(responseString);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}




