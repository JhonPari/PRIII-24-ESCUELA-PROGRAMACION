class ReporteEstudiante {
  String nombre;
  String correo;
  int puntos;

  ReporteEstudiante({
    required this.nombre,
    required this.correo,
    required this.puntos,
  });

  factory ReporteEstudiante.fromJson(Map<String, dynamic> json) {
    return ReporteEstudiante(
      nombre: json['nombre_Estudiante'] ?? 'Sin Nombre', // Campo actualizado
      correo: json['correo_Estudiante'] ?? 'Sin Correo', // Campo actualizado
      puntos: json['total_Puntos'] ?? 0, // Campo actualizado
    );
  }
}
