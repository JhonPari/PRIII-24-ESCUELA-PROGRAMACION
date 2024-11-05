// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/VerCompetencias.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/vistaDoce_reportes/vistaDoce_porFechas.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/NavbarMenus.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class MenuDoce extends StatefulWidget {
  const MenuDoce({super.key});

  @override
  _MenuDoceState createState() => _MenuDoceState();
}

class _MenuDoceState extends State<MenuDoce> {
  final storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    
    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre'; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarMenus(name ?? '...', storage, context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navegación para Ver Reportes
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VistaDoceReporteFecha(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B2D56),
                  minimumSize: const Size(300, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: const Text(
                  'Ver Reportes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navegación para Competencia
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerCompetenciaDocePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B2D56),
                  minimumSize: const Size(300, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: const Text(
                  'Competencia',
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
