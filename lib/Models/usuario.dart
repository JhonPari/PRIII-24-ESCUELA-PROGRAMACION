import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuario {
  int id;
  String nombre;
  String contrasenia;
  String correo;
  String rol;
  int idUsuario;
  DateTime fechaRegistro;
  DateTime? fechaActualizacion;
  String estado;
  String solicitud;

  // Constructor
  Usuario({
    required this.id,
    required this.nombre,
    required this.contrasenia,
    required this.correo,
    required this.rol,
    required this.idUsuario,
    required this.fechaRegistro,
    this.fechaActualizacion,
    required this.estado,
    required this.solicitud,
  });

  // Método para crear un Usuario a partir de un JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      contrasenia: json['contrasenia'],
      correo: json['correo'],
      rol: json['rol'],
      idUsuario: json['idUsuario'],
      fechaRegistro: DateTime.parse(json['fecha_Registro']),
      fechaActualizacion: json['fecha_Actualizacion'] != null
          ? DateTime.parse(json['fecha_Actualizacion'])
          : null,
      estado: json['estado'],
      solicitud: json['solicitud'],
    );
  }

  // Método para convertir un Usuario a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'contrasenia': contrasenia,
      'correo': correo,
      'rol': rol,
      'idUsuario': idUsuario,
      'fecha_Registro': fechaRegistro.toIso8601String(),
      'fecha_Actualizacion': fechaActualizacion?.toIso8601String(),
      'estado': estado,
      'solicitud': solicitud,
    };
  }

  // Método para enviar los datos a la API
  Future<void> registrarUsuario(String apiUrl) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toJson()), // Convertimos el usuario a JSON
    );

    if (response.statusCode == 201) {
      // Usuario registrado correctamente
      print('Usuario registrado');
    } else {
      // Error al registrar usuario
      print('Error: ${response.statusCode}');
    }
  }
}