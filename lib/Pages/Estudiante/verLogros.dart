import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/LogroEst.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/est_navbar.dart';
import 'package:prlll_24_escuela_programacion/Service/CompetenciasService.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class VerLogrosPage extends StatefulWidget {
  final int idEst;

  const VerLogrosPage({super.key, required this.idEst});

  @override
  State<VerLogrosPage> createState() => _VerLogrosState();

  static fromJson(json) {}
}

class _VerLogrosState extends State<VerLogrosPage> {
  CompetenciasService competenciasService = CompetenciasService();
  late Future<List<LogrosEst>> _listaLogros;
  final storage = Session();
  String? name;
  int id = 0;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _listaLogros = competenciasService.getLogrosEstudiante(widget.idEst);
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
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
        
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
          children: [
            const SizedBox(height: 30),
            const Text(
              'HISTORIAL DE LOGROS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E244D),
              ),
            ),
            const SizedBox(height: 20),
            tablaLogros(),
          ],
        ),
      ),
    ));
  }

  Expanded tablaLogros() {
    return Expanded(
      child: FutureBuilder<List<LogrosEst>>(
        future: _listaLogros,
        builder:
            (BuildContext context, AsyncSnapshot<List<LogrosEst>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay logros', style: TextStyle(fontSize: 18)));
          } else {
            List<LogrosEst> logros = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0BFC7), // Fondo rosado para la tabla
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Para scroll horizontal si es necesario
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Logro')),
                      DataColumn(label: Text('Fecha')),
                      DataColumn(label: Text('Estado de aprobacion')),
                      DataColumn(label: Text('Prueba certificado')),
                    ],
                    rows: logros.map((logro) {
                      return DataRow(
                        cells: [
                          DataCell(Text(logro.titulo)),
                          DataCell(Text(logro.fechaInicio.toIso8601String())),
                          DataCell(Text(
                            () {
                              switch (logro.aprobado) {
                                case 0:
                                  return "Pendiente";
                                case 1:
                                  return "Aprobado";
                                case 2:
                                  return "Reprobado";
                                default:
                                  return "Desconocido";
                              }
                            }(),
                          )),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                //TODO boton pendiente carga imagen
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.black),
                              child: const Text(
                                'Ver Prueba',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
