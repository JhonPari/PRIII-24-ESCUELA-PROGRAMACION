import 'dart:convert';
import 'package:prlll_24_escuela_programacion/Models/ReporteFechas.dart';
import 'package:prlll_24_escuela_programacion/Models/Reportes.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  final String baseUri = "https://localhost:7096/Usuarios";

  Future<List<Usuario>> getEstudiantes() async {
    final url = Uri.parse("$baseUri/Estudiantes");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar todos los Usuarios");
    }
  }
  Future<List<Usuario>> getDocentes() async {
    final url = Uri.parse("$baseUri/Docentes");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar todos los Usuarios");
    }
  }
//lista verificar Docente
  Future<List<Usuario>> getListaPendienteDocente() async {
    final url = Uri.parse("$baseUri/listaPendienteDocentes");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar todos los Usuarios");
    }
  }
  //lista verificar estudiante
    Future<List<Usuario>> getListaPendienteEstudiante() async {
    final url = Uri.parse("$baseUri/listaPendienteEstudiante");
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

  Future<void> put(int id, Usuario usr) async {
    final url = Uri.parse("$baseUri/$id");
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usr.toJson()), // Convertir Usuario a JSON
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Error al actualizar un Usuario");
    }
  }
  
  Future<void> deleteLogic(int id) async {
    final url = Uri.parse("$baseUri/$id");
    // En la API deberías actualizar su estado a 'E'
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Error al eliminar lógicamente un Usuario");
    }
  }
  //para aceptar usuarios
  Future<void> putAceptarSolicitud(int id, Usuario usr) async {
    final url = Uri.parse("$baseUri/archivarSolicitud/$id"); // Ruta para actualizar la solicitud a "A"
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usr.toJson()), // Convertir Usuario a JSON
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Error al actualizar la solicitud del Usuario");
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
  Future<Map<String, dynamic>?> login(String correo, String passw) async {
    final url = Uri.parse("$baseUri/Login");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Correo': correo, 'Contrasenia': passw}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
  Future<List<ReporteEstudiante>> getReportEstudiantes() async {
  final url = Uri.parse("$baseUri/EstudiantesReporte");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => ReporteEstudiante.fromJson(json)).toList();
  } else {
    throw Exception("Error al cargar todos los Reportes de Estudiantes");
  }
}
Future<List<ReporteEstudianteFecha>> getReportEstudiantesFecha() async {
  final url = Uri.parse("$baseUri/EstudiantesReporteFecha");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData
        .map((json) => ReporteEstudianteFecha.fromJson(json))
        .toList();
  } else {
    throw Exception("Error al cargar todos los reportes de estudiantes");
  }
}

 Future<bool> recuperarContrasena(String correo) async {
    final url = Uri.parse('$baseUri/RecuperarContrasenia');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo}),
    );
 
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changePassword(String correo, String currentPassword, String newPassword) async {
    final url = Uri.parse('$baseUri/CambiarContrasenia');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Correo': correo,
        'ContraseniaActual': currentPassword,
        'NuevaContrasenia': newPassword
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
  Future<int> getPoints(int id) async {
    final url = Uri.parse('$baseUri/EstPoints/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['puntos'];
    } else {
      throw Exception('Error al obtener los puntos');
    }
  }
}
