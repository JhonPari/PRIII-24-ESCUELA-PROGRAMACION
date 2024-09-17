class Escuela {
  int id;
  String nombre;
  DateTime? fechaRegistro;
  DateTime? fechaActualizacion; // Puede ser nulo
  String estado;
  String descripcion;

  // Constructor
  Escuela({
    required this.id,
    required this.nombre,
    required this.fechaRegistro,
    this.fechaActualizacion,
    required this.estado,
    required this.descripcion,
  });

  // Método para crear una Escuela a partir de un JSON (deserialización)
  factory Escuela.fromJson(Map<String, dynamic> json) {
    return Escuela(
      id: json['id'],
      nombre: json['nombre'],
      fechaRegistro: DateTime.parse(json['fecha_Registro']),
      fechaActualizacion: json['fecha_Actualizacion'] != null
          ? DateTime.parse(json['fecha_Actualizacion'])
          : null,
      estado: json['estado'],
      descripcion: json['descripcion'],
    );
  }
  // Método para convertir una Escuela a JSON (serialización)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fecha_Registro': fechaRegistro?.toIso8601String(),
      'fecha_Actualizacion': fechaActualizacion?.toIso8601String(),
      'estado': estado,
      'descripcion': descripcion,
    };
  }
}

class NewEscuela {
  String nombre;
  String descripcion;

  NewEscuela({
    required this.nombre,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}