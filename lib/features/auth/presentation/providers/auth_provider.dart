// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/auth_service.dart';
import '../../domain/models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      await fetchPerfil();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String matricula, String contrasena) async {
    _isLoading = true;
    notifyListeners();
    
    final result = await AuthService.login(matricula, contrasena);
    if (result['success'] == true) {
      final token = result['data']['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      
      final userData = Map<String, dynamic>.from(result['data']);
      if (userData['matricula'] == null) userData['matricula'] = matricula;
      _user = User.fromJson(userData);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      throw Exception(result['message'] ?? 'Error al iniciar sesión');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _user = null;
    notifyListeners();
  }

  Future<void> fetchPerfil() async {
    final result = await AuthService.getPerfil();
    if (result['success'] == true) {
      _user = User.fromJson(result['data']);
    } else {
      await logout();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfilePhoto(XFile file) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.updateProfilePhoto(file);
      if (result['success'] == true) {
        await fetchPerfil(); // Refresh user data
      } else {
        throw Exception(result['message'] ?? 'Error al actualizar foto');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> activarCuenta(String? token, String contrasena) async {
    _isLoading = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final effectiveToken = (token == null || token.isEmpty) ? prefs.getString('token') : token;
      
      if (effectiveToken == null) throw Exception('No hay un token disponible');

      final result = await AuthService.activar(effectiveToken, contrasena);
      if (result['success'] == true) {
        final newToken = result['data']['token'];
        await prefs.setString('token', newToken);
        _user = User.fromJson(result['data']);
      } else {
        throw Exception(result['message'] ?? 'Error al actualizar contraseña');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cambiarClave(String actual, String nueva) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await AuthService.cambiarClave(actual, nueva);
      if (result['success'] == true) {
        // Contraseña actualizada
      } else {
        throw Exception(result['message'] ?? 'Error al modificar contraseña');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

