// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import '../../data/vehiculo_service.dart';
import '../../domain/models/vehiculo.dart';

class VehiculoProvider with ChangeNotifier {
  List<Vehiculo> _vehiculos = [];
  bool _isLoading = false;

  List<Vehiculo> get vehiculos => _vehiculos;
  bool get isLoading => _isLoading;

  Future<void> fetchVehiculos({int page = 1}) async {
    _isLoading = true;
    notifyListeners();

    final result = await VehiculoService.getVehiculos(page: page);
    if (result['success'] == true) {
      final List data = result['data'];
      _vehiculos = data.map((v) => Vehiculo.fromJson(v)).toList();
    }
    
    _isLoading = false;
    notifyListeners();
  }
}

