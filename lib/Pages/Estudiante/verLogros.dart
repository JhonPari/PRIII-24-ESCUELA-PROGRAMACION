// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/LogroEst.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/est_navbar.dart';
import 'package:prlll_24_escuela_programacion/Service/CompetenciasService.dart';
import 'package:prlll_24_escuela_programacion/Service/ImagenesService.dart';
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
  ImagenesService imagenesService = ImagenesService();
  late Future<List<LogrosEst>> _listaLogros;
  final storage = Session();
  String? name;
  int id = 0;
  Uint8List? _imagenSeleccionada;

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
        id = int.parse(data['id']!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: estNavBar(name ?? '...', storage, context, id),
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
            const SizedBox(height: 20),
            _imagenSeleccionada != null
                ? tarjetaImagen(_imagenSeleccionada!)
                : const SizedBox(),
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
                            logro.imagen == 1 // hay imagen subida
                                ? ElevatedButton(
                                    onPressed: () async {
                                      // Llamar al servicio para obtener la imagen
                                      Uint8List? imagen = await imagenesService
                                          .obtenerImagen(logro.id);
                                      if (imagen != null) {
                                        setState(() {
                                          _imagenSeleccionada = imagen;
                                        });
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    child: const Text(
                                      'Ver Prueba',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : const Text("No se subió una prueba"),
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

  Widget tarjetaImagen(Uint8List img) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.memory(
            img,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
