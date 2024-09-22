import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prlll_24_escuela_programacion/Models/LogroEst.dart';

class CompetenciasService {
  final String baseUri = "https://localhost:7096/Competencias/Est";

  Future<List<LogrosEst>> getLogrosEstudiante(int idEst) async {
    final url = Uri.parse("$baseUri?idEstudiante=$idEst");  // Formato de la URL con parámetro

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<LogrosEst>((json) => LogrosEst.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar los logros del estudiante");
    }
  }
}
