import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/EstCompetencias.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/verLogros.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/est_navbar.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
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
  final storage = Session();
  String? name;
  int id = 0;

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
    }
    else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre'; 
        id = int.parse(data['id']!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: estNavBar(name ?? '...', storage, context,id),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '1000  Pts',
                style: TextStyle(
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
                    MaterialPageRoute(builder: (context) => const EstCompetenciaPage()),
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
                    MaterialPageRoute(builder: (context) => VerLogrosPage(idEst: id)),
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
