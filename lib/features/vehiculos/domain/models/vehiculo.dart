// Hideki Rafael Sarmiento Ariyama 20241453
class Vehiculo {
  final int id;
  final String placa;
  final String chasis;
  final String marca;
  final String modelo;
  final int anio;
  final int cantidadRuedas;
  final String? fotoUrl;
  final String? fechaRegistro;
  final Map<String, dynamic>? resumen;

  Vehiculo({
    required this.id,
    required this.placa,
    required this.chasis,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.cantidadRuedas,
    this.fotoUrl,
    this.fechaRegistro,
    this.resumen,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      id: json['id'],
      placa: json['placa'] ?? '',
      chasis: json['chasis'] ?? '',
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      anio: json['anio'] is int ? json['anio'] : int.tryParse(json['anio'].toString()) ?? 0,
      cantidadRuedas: json['cantidad_ruedas'] ?? json['cantidadRuedas'] ?? 4,
      fotoUrl: json['foto_url'] ?? json['fotoUrl'],
      fechaRegistro: json['fecha_registro'] ?? json['fechaRegistro'],
      resumen: json['resumen'],
    );
  }
}

