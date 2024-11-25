import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prlll_24_escuela_programacion/Service/ServicioBase.dart';
import 'package:prlll_24_escuela_programacion/models/Escuela.dart';

class EscuelaService {
  final String baseUri = "$basePage/api/Escuela";

  Future<List<Escuela>> getAll() async {
    final url = Uri.parse(baseUri);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Escuela.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar todas las Escuelas");
    }
  }

  Future<Escuela> get(int id) async {
    final url = Uri.parse("$baseUri/$id");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return Escuela.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al cargar una escuela");
    }
  }

  Future<Escuela> post(NewEscuela usr) async {
    final url = Uri.parse(baseUri);
    var a = jsonEncode(usr.toJson());

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: a, // Convertir Usuario a JSON
    );

    if (response.statusCode == 201) {
      return Escuela.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear una Escuela");
    }
  }

  Future<void> put(int id, Escuela escuelaModificada) async {
    final url = Uri.parse("$baseUri/$id");
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(escuelaModificada.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          "Error al actualizar la escuela. Código de estado: ${response.statusCode}");
    }
  }

  Future<void> deleteLogic(int id) async {
    final url = Uri.parse("$baseUri/$id/logic-delete");
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204) {
      throw Exception("Error al eliminar lógicamente una Escuela");
    }
  }
}
