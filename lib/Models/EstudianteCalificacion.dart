import 'dart:convert';

class Estudiante {
  final String nombre;
  final String correo;
  final int aprobado;
  final int id;

  Estudiante({
    required this.nombre,
    required this.correo,
    required this.aprobado,
    required this.id,
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    final aprobado = json['aprobado'];
    final id = json['id'];

    if (aprobado == null || !(aprobado is int)) {
      print('Invalid or missing aprobado value: $aprobado');
      return Estudiante(
        nombre: json['nombre'] ?? '',
        correo: json['correo'] ?? '',
        aprobado: 0, // Valor predeterminado si no es válido
        id: id, // Valor predeterminado para idCalificacion
      );
    }

    return Estudiante(
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      aprobado: aprobado,
      id: id, // Valor predeterminado para idCalificacion
    );
  }
}
