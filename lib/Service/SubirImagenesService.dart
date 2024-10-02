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

  // Crear el MultipartFile desde Uint8List
  var multipartFile = http.MultipartFile.fromBytes(
    'imagen',
    imagenSubida.imagen,
    filename: imagenSubida.nombre,
    contentType: MediaType('application', 'octet-stream'),
  );

  // Agregar el MultipartFile a la solicitud
  request.files.add(multipartFile);

  try {
    // Imprimir para depuración
    print('Enviando imagen de tamaño: ${imagenSubida.imagen.length} bytes');

    // Enviar la solicitud
    var response = await request.send();

    // Procesar la respuesta
    if (response.statusCode == 200) {
      print('Imagen enviada correctamente.');
      return true;
    } else {
      // Manejar el error y obtener el mensaje de respuesta
      final responseData = await response.stream.bytesToString();
      print('Error: $responseData');
      return false;
    }
  } catch (e) {
    // Manejar excepciones
    print('Excepción: $e');
    return false;
  }
}
}
