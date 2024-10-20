class ReporteEstudianteFecha {
  String nombre;
  String correo;
  int puntos;
  DateTime fechaInicioCompetencia;

  ReporteEstudianteFecha({
    required this.nombre,
    required this.correo,
    required this.puntos,
    required this.fechaInicioCompetencia,
  });

  factory ReporteEstudianteFecha.fromJson(Map<String, dynamic> json) {
    return ReporteEstudianteFecha(
      nombre: json['nombreUsuario'] ?? 'Sin Nombre',
      correo: json['correoUsuario'] ?? 'Sin Correo',
      puntos: json['totalPuntos'] ?? 0,
      fechaInicioCompetencia: DateTime.parse(json['fechaInicioCompetencia']),
    );
  }
}
