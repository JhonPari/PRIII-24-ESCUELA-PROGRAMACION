import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:prlll_24_escuela_programacion/Models/ImagenLogroEst.dart';
import 'package:prlll_24_escuela_programacion/Models/SubirImagen.dart';

class ImagenesService {
  final String baseUri = "https://localhost:7096/Images";

  Future<bool> subirImagen(SubirImagen imagenSubida) async {
    final url = Uri.parse("$baseUri/subirImagen");

    var request = http.MultipartRequest('POST', url);
    request.fields['idCompetencia'] = imagenSubida.idCompetencia.toString();
    request.fields['idEstudiante'] = imagenSubida.idEstudiante.toString();

    request.files.add(http.MultipartFile.fromBytes(
      'imagen',
      imagenSubida.imagen,
      filename: imagenSubida.nombre,
      contentType: MediaType('image', imagenSubida.nombre.split('.').last),
    ));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<ImagenLogrosEst?> obtenerImagen(int idCalificacion) async {
    final url = Uri.parse("$baseUri/obtenerImagen/$idCalificacion");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return ImagenLogrosEst(
        idCalificacion: data['idCalificacion'],
        nombre: data['nombre'],
        archivo: response.bodyBytes,
      );
    } else {
      return null;
    }
  }
}
