import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:prlll_24_escuela_programacion/Models/CompetenciaEst.dart';
import 'package:prlll_24_escuela_programacion/Models/LogroEst.dart';
import 'package:prlll_24_escuela_programacion/Service/ServicioBase.dart';

class CompetenciasService {
  final String baseUri = "$basePage/Competencias";

  Future<List<LogrosEst>> getLogrosEstudiante(int idEst) async {
    final url = Uri.parse("$baseUri/Logros?idEstudiante=$idEst");  // Formato de la URL con parámetro

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<LogrosEst>((json) => LogrosEst.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar los logros del estudiante");
    }
  }
  
  Future<List<CompetenciaEst>> getCompetenciasEstudiante(int idEst) async {
    final url = Uri.parse("$baseUri/Competencias?idEstudiante=$idEst");  // Formato de la URL con parámetro

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<CompetenciaEst>((json) => CompetenciaEst.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar las competencias del estudiante");
    }
  }

}
