import 'dart:typed_data';

class SubirImagen {
  int idCompetencia;
  int idEstudiante;
  Uint8List imagen;
  String nombre;

  // Constructor
  SubirImagen(
      {required this.idCompetencia,
      required this.idEstudiante,
      required this.imagen,
      required this.nombre});
}
