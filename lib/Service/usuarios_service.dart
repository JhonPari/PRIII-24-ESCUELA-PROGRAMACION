import 'dart:convert';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  final String baseUri = "https://localhost:7096/Usuarios";

  Future<List<Usuario>> getAll() async {
    final url = Uri.parse(baseUri);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar todos los Usuarios");
    }
  }

  Future<Usuario> get(int id) async {
    final url = Uri.parse("$baseUri/$id");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al cargar un Usuario");
    }
  }

  Future<Usuario> post(NewUsuario usr) async {
    final url = Uri.parse(baseUri);
    var a = jsonEncode(usr.toJson());

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: a, // Convertir Usuario a JSON
    );

    if (response.statusCode == 201) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear un Usuario");
    }
  }

  Future<Usuario> put(int id, Usuario usr) async {
    final url = Uri.parse("$baseUri/$id");
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usr.toJson()), // Convertir Usuario a JSON
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al actualizar un Usuario");
    }
  }

  Future<Usuario> deleteLogic(int id, Usuario usr) async {
    final url = Uri.parse("$baseUri/$id");
    // En la API deberías actualizar su estado a 'E'
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usr.toJson()), // Convertir Usuario a JSON
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al eliminar lógicamente un Usuario");
    }
  }

  // Método para eliminar físicamente un usuario (si lo necesitas más adelante)
  // Future<Usuario> delete(int id) async {
  //   final url = Uri.parse("$baseUri/$id");
  //   var response = await http.delete(url);
  //
  //   if (response.statusCode == 200) {
  //     return Usuario.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Error al eliminar un Usuario");
  //   }
  // }
}
