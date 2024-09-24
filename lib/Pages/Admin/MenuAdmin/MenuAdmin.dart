import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/ListaDeDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/vista_escuela.dart'; 
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/Vista_Estudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEstudiante/vista_reporte.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/NavbarMenus.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

void main() {
  runApp(const MenuAdmin());
}

class MenuAdmin extends StatefulWidget {
  const MenuAdmin({super.key});

  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  final storage = Session();
  String? name;

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
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: NavBarMenus(name ?? '...', storage, context),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navegación para Tareas (descomentar cuando la clase esté disponible)
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TareasPage(),
                          ),
                        );
                        */
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B2D56),
                        minimumSize: const Size(500, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
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
                        // Navegación para Ver Reportes
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaReporte(),
                          ),
                        );
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B2D56),
                        minimumSize: const Size(500, 80),
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
                        // Navegación para Calificaciones
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalificacionesPage(),
                          ),
                        );
                        */
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B2D56),
                        minimumSize: const Size(500, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: const Text(
                        'Calificaciones',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navegación a la lista de estudiantes
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VistaEst(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B2D56),
                        minimumSize: const Size(500, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: const Text(
                        'Lista de Estudiantes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navegación a la lista de docentes
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaDoce(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B2D56),
                        minimumSize: const Size(500, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: const Text(
                        'Lista de Docentes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navegación a la lista de escuelas (corregida a VistaDoce)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaEscuela(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B2D56),
                        minimumSize: const Size(500, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: const Text(
                        'Lista de Escuelas',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/images/campus.jpg', // Ruta correcta de la imagen
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
