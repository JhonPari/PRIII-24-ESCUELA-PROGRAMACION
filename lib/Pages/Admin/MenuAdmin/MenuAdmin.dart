import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/Calificar/VerCompetenciasAdmin.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/ListaDeDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/vista_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/Vista_Estudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/Habilitar/VistaInhabilitados.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ListaPendiente/AceptarDocente.dart';
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
    return MaterialApp(
      home: Scaffold(
        appBar: NavBarMenus(name ?? '...', storage, context),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // Espaciado
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton('Lista Pendientes', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerificarDoce(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('Calificar', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const verCompetenciaAdmin(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('Reportes', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaReporte(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('Lista de Estudiantes', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaEst(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('Lista de Docentes', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaDoce(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('Lista de Escuelas', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaEscuela(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildButton('Lista de Inhabilitados', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VistaInhabilitados(),
                          ),
                        );
                      }),
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
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return FractionallySizedBox(
      widthFactor: 0.8, // Ocupa el 80% del ancho disponible
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B2D56),
          minimumSize: const Size(0, 60), // Tamaño mínimo en altura
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
