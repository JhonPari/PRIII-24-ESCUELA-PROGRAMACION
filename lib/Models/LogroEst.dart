class LogrosEst {
  int id;
  String titulo;
  DateTime fechaInicio;
  int aprobado;
  int imagen;

  LogrosEst({
    required this.id,
    required this.titulo,
    required this.fechaInicio,
    required this.aprobado,
    required this.imagen,
  });

  // Factory constructor para crear una instancia desde JSON
  factory LogrosEst.fromJson(Map<String, dynamic> json) {
    return LogrosEst(
      id: json['id'],
      titulo: json['titulo'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      aprobado: json['aprobado'],
      imagen: json['imagen'],
    );
  }

  // Método para convertir una instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'fechaInicio': fechaInicio.toIso8601String(),
      'aprobado': aprobado,
      'imagen': imagen,
    };
  }
}
