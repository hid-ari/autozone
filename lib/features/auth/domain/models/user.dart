// Hideki Rafael Sarmiento Ariyama 20241453
class User {
  final int id;
  final String nombre;
  final String apellido;
  final String correo;
  final String? fotoUrl;
  final String? matricula;
  final String? rol;
  final String? grupo;
  final String? fechaRegistro;
  final String? token;
  final String? refreshToken;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    this.fotoUrl,
    this.matricula,
    this.rol,
    this.grupo,
    this.fechaRegistro,
    this.token,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      correo: json['correo'] ?? '',
      fotoUrl: json['fotoUrl'],
      matricula: json['matricula']?.toString(),
      rol: json['rol'],
      grupo: json['grupo'],
      fechaRegistro: json['fechaRegistro'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'fotoUrl': fotoUrl,
      'matricula': matricula,
      'rol': rol,
      'grupo': grupo,
      'fechaRegistro': fechaRegistro,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}

