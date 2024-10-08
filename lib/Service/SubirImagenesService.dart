import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:prlll_24_escuela_programacion/Models/SubirImagen.dart';

class SubirImagenesService {
  final String baseUri = "https://localhost:7096/Images/subirImagen";

  Future<bool> subir(SubirImagen imagenSubida) async {
    final url = Uri.parse(baseUri);

    var request = http.MultipartRequest('POST', url);
    request.fields['idCompetencia'] = imagenSubida.idCompetencia.toString();
    request.fields['idEstudiante'] = imagenSubida.idEstudiante.toString();

    request.files.add(http.MultipartFile.fromBytes(
      'imagen',
      imagenSubida.imagen,
      filename: imagenSubida.nombre,
      contentType:
          MediaType('image', imagenSubida.nombre.split('.').last),
    ));

    try {
      print('Enviando imagen de tamaño: ${imagenSubida.imagen.length} bytes');
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      }         
      
      return false;
    } catch (e) {
      return false;
    }
  }
}
