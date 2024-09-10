class Usuario {
  int? id;
  String nombre;
  String contrasenia;
  String correo;
  String rol;
  int idUsuario;
  DateTime? fechaRegistro;
  DateTime? fechaActualizacion; // Puede ser nulo
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

  // Método para crear un Usuario a partir de un JSON (deserialización)
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

  // Método para convertir un Usuario a JSON (serialización)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'contrasenia': contrasenia,
      'correo': correo,
      'rol': rol,
      'idUsuario': idUsuario,
      'fecha_Registro': fechaRegistro?.toIso8601String(),
      'fecha_Actualizacion': fechaActualizacion?.toIso8601String(),
      'estado': estado,
      'solicitud': solicitud,
    };
  }
}

class NewUsuario {
  String nombre;
  String contrasenia;
  String correo;
  String rol;
  int idUsuario;
  String solicitud;

  NewUsuario({
    required this.nombre,
    required this.contrasenia,
    required this.correo,
    required this.rol,
    required this.idUsuario,
    required this.solicitud,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'contrasenia': contrasenia,
      'correo': correo,
      'rol': rol,
      'idUsuario': idUsuario,
      'solicitud': solicitud,
    };
  }
}