import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/docente/EstudianteCompetencia.dart';
import 'package:prlll_24_escuela_programacion/Service/CalificarEstudianteService.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/DocenteNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class CalificarPrueba extends StatefulWidget {
  final int id;

  CalificarPrueba({required this.id});

  @override
  CalificarPruebaState createState() => CalificarPruebaState();
}

class CalificarPruebaState extends State<CalificarPrueba> {
  String? competenciaTitulo;
  String? estudianteNombre;
  final storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _loadData();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    
    if (data['name'] != null) {
      setState(() {
        name = data['name']!;
      });
    }
  }

  Future<void> _loadData() async {
    try {
      final data = await fetchCalificacionById(widget.id);
      setState(() {
        competenciaTitulo = data['competenciaTitulo'];
        estudianteNombre = data['estudianteNombre'];
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> _updateCalificacion(int aprobado) async {
    try {
      await updateCalificacion(widget.id, aprobado);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CompetenciaPage()),
      );
    } catch (e) {
      print('Error updating calificacion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: docenteNavBar(name ?? '...', storage, context), // Reemplaza el AppBar por el docenteNavBar
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 500,
                          height: 350,
                          color: const Color.fromARGB(153, 243, 243, 243),
                          child: const Icon(
                            Icons.image,
                            size: 100,
                            color: Color.fromARGB(255, 115, 115, 115),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          competenciaTitulo ?? 'Cargando...',
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          estudianteNombre ?? 'Cargando...',
                          style: const TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 227, 227, 227)),
                        ),
                        const SizedBox(height: 30),
                        const Text("Participación"),
                        const SizedBox(height: 10),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _updateCalificacion(1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF16772B),
                                minimumSize: const Size(60, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                ' Aceptar ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 40),
                            ElevatedButton(
                              onPressed: () {
                                _updateCalificacion(2);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B2D56),
                                minimumSize: const Size(60, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Reprobar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
