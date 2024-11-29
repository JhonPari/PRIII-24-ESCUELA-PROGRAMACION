class CompetenciaEst {
  final int id;
  final String titulo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String estado;
  final int imagen;
  final int revisado;

  const CompetenciaEst({
    required this.id,
    required this.titulo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
    required this.imagen,
    required this.revisado,
  });

  factory CompetenciaEst.fromJson(Map<String, dynamic> json) {
    return CompetenciaEst(
      id: json['id'],
      titulo: json['titulo'],
      fechaInicio: DateTime.parse(json['fecha_Inicio']),
      fechaFin: DateTime.parse(json['fecha_Fin']),
      estado: json['estado'],
      imagen: json['imagen'],
      revisado: json['revisado'],
    );
  }
}
