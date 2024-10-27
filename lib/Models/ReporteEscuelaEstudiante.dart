class ReporteEscuelaEstudiante {
  final String nombreEscuela;
  final String tituloCompetencia;
  final String nombreEstudiante;
  final String correoEstudiante;

  ReporteEscuelaEstudiante({
    required this.nombreEscuela,
    required this.tituloCompetencia,
    required this.nombreEstudiante,
    required this.correoEstudiante,
  });

  factory ReporteEscuelaEstudiante.fromJson(Map<String, dynamic> json) {
    return ReporteEscuelaEstudiante(
      nombreEscuela: json['nombreEscuela'] ?? 'Sin Escuela',
      tituloCompetencia: json['tituloCompetencia'] ?? 'Sin Competencia',
      nombreEstudiante: json['nombreEstudiante'] ?? 'Sin Estudiante',
      correoEstudiante: json['correoEstudiante'] ?? 'Sin Correo',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreEscuela': nombreEscuela,
      'tituloCompetencia': tituloCompetencia,
      'nombreEstudiante': nombreEstudiante,
      'correoEstudiante': correoEstudiante,
    };
  }
}
