class LogrosEst {
  String titulo;
  DateTime fechaInicio;
  int aprobado;

  LogrosEst({
    required this.titulo,
    required this.fechaInicio,
    required this.aprobado,
  });

  // Factory constructor para crear una instancia desde JSON
  factory LogrosEst.fromJson(Map<String, dynamic> json) {
    return LogrosEst(
      titulo: json['titulo'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      aprobado: json['aprobado'],
    );
  }

  // Método para convertir una instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'fechaInicio': fechaInicio.toIso8601String(),
      'aprobado': aprobado,
    };
  }
}