import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prlll_24_escuela_programacion/models/EstudianteCalificacion.dart'; 
Future<List<Estudiante>> fetchEstudiantesSer(int competenciaId) async {
  final String apiUrl =
      'https://localhost:7096/FiltrarEstudiante/$competenciaId';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data
          .map((json) {
            try {
              return Estudiante.fromJson(json);
            } catch (e) {
              print('Error parseando estudiante: $e');
              return null;
            }
          })
          .where((estudiante) => estudiante != null)
          .cast<Estudiante>()
          .toList();
    } else {
      throw Exception('Error estudiantes: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
    throw Exception('Error: $e');
  }
}

/*Future<List<Estudiante>> fetchEstudiantesSer() async {
  const String apiUrl =
      'https://localhost:7096/api/Cslificacion/with-student-info';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data
          .map((json) {
            try {
              return Estudiante.fromJson(json);
            } catch (e) {
              print('Error parseando estudiante: $e');
              return null;
            }
          })
          .where((estudiante) => estudiante != null)
          .cast<Estudiante>()
          .toList();
    } else {
      throw Exception('Error estudiantes: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
    throw Exception('Error: $e');
  }
}*/

Future<Map<String, dynamic>> fetchCalificacionById(int id) async {
  final String apiUrl = 'https://localhost:7096/$id';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(': ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
    throw Exception('Error calificacion: $e');
  }
}

Future<void> updateCalificacion(int id, int aprobado) async {
  final url =
      Uri.parse('https://localhost:7096/$id/Calificar');

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'id': id,
      'aprobado': aprobado,
    }),
  );

  if (response.statusCode != 204) {
    throw Exception('Error al  calificacion');
  }
}
