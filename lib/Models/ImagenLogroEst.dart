import 'dart:typed_data';

class ImagenLogrosEst {
  int idCalificacion;
  String nombre;
  Uint8List archivo;

  ImagenLogrosEst({
    required this.idCalificacion,
    required this.nombre,
    required this.archivo,
  });
}