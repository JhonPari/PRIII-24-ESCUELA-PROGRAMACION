/*class ReportefechaEstudiante {
  String nombre;
  String correo;
  DateTime fechaInicio; // Cambiado a DateTime
  int puntos;

  ReportefechaEstudiante({
    required this.nombre,
    required this.correo,
    required this.fechaInicio
  });

  factory ReportefechaEstudiante.fromJson(Map<String, dynamic> json) {
    return ReportefechaEstudiante(
      nombre: json['nombre_Estudiante'] ?? 'Sin Nombre', // Campo actualizado
      correo: json['correo_Estudiante'] ?? 'Sin Correo', // Campo actualizado
      fechaInicio: DateTime.parse(json['fecha_Inicio']),
      
    );
  }
}*/