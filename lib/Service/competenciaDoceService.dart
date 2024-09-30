import 'dart:convert';
import 'package:prlll_24_escuela_programacion/models/Competencia.dart';
import 'package:http/http.dart' as http;

class CompetenciaDoceService {
  final String baseUri = "https://localhost:7096/Competencias/CompetenciasDoce";

  Future<List<Competencia>> getAll() async {
    final url = Uri.parse(baseUri);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Competencia.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar todas las Escuelas");
    }
  }
}