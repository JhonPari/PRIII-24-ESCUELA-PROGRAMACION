// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/EstCompetencias.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/verLogros.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/NavbarMenus.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/pages/Login/login.dart';

void main() {
  runApp(const MenuEst());
}

class MenuEst extends StatefulWidget {
  const MenuEst({super.key});

  @override
  _MenuEstState createState() => _MenuEstState();
}

class _MenuEstState extends State<MenuEst> {
  UsuariosService usuariosService = UsuariosService();
  final storage = Session();
  String? name;
  int id = 0;
  late int puntos = 0;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    // Obtiene el mapa con los datos de la sesión
    Map<String, String?> data = await storage.getSession();

    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      //if del rol
    } else {
      int p = await usuariosService.getPoints(int.parse(data['id']!));
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
        id = int.parse(data['id']!);
        puntos = p;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: NavBarMenus(name ?? '...', storage, context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$puntos pts',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'PUNTOS TOTALES',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Redirigir a la página de Tareas
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EstCompetenciaPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B2D56),
                  minimumSize: const Size(300, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tareas',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Redirigir a la página de Logros
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerLogrosPage(idEst: id)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B2D56),
                  minimumSize: const Size(300, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'VER LOGROS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}