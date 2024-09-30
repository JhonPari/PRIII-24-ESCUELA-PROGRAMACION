class Competencia {
  int id;
  String? titulo;
  String? descripcion;
  DateTime? fechaInicio;
  DateTime? fechaFin; // Puede ser nulo
  List<dynamic>? calificaciones; // Puede ser nulo

  // Constructor
  Competencia({
    required this.id,
    this.titulo,
    this.descripcion,
    this.fechaInicio,
    this.fechaFin,
    this.calificaciones,
  });

  factory Competencia.fromJson(Map<String, dynamic> json) {
    return Competencia(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fechaInicio: json['fecha_Inicio'] != null ? DateTime.parse(json['fecha_Inicio']) : null,
      fechaFin: json['fecha_Fin'] != null ? DateTime.parse(json['fecha_Fin']) : null,
      calificaciones: json['calificaciones'],
    );
  }
}
