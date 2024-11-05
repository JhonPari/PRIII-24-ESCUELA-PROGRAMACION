// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/DocenteNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/CalificarEstudianteService.dart';
import 'package:prlll_24_escuela_programacion/Service/ImagenesService.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Pages/docente/EstudianteCompetencia.dart';

class CalificarPrueba extends StatefulWidget {
  final int id;
  final int idCompetencia;

  const CalificarPrueba({
    super.key,
    required this.id,
    required this.idCompetencia,
  });

  @override
  CalificarPruebaState createState() => CalificarPruebaState();
}

class CalificarPruebaState extends State<CalificarPrueba> {
  ImagenesService imagenesService = ImagenesService();
  String? competenciaTitulo;
  String? estudianteNombre;
  final storage = Session();
  String? name;
  Uint8List? _imagenSeleccionada;

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();

    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      if (!mounted) return;
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

  Future<void> _loadData() async {
    try {
      final data = await fetchCalificacionById(widget.id);
      setState(() {
        competenciaTitulo = data['competenciaTitulo'];
        estudianteNombre = data['estudianteNombre'];
      });

      Uint8List? imagen = await imagenesService.obtenerImagen(widget.id);
      if (imagen != null) {
        setState(() {
          _imagenSeleccionada = imagen;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> _updateCalificacion(int aprobado) async {
    try {
      await updateCalificacion(widget.id, aprobado);

      if (!mounted) return;

      _mostrarDialogoCalificacion(aprobado == 1);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CompetenciaPage(idCompetencia: widget.idCompetencia),
        ),
      );
    } catch (e) {
      print('Error updating calificacion: $e');
    }
  }

  void _mostrarDialogoCalificacion(bool esExitoso) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(esExitoso ? 'Calificación exitosa' : 'Calificación fallida'),
          content: Row(
            children: [
              Icon(
                esExitoso ? Icons.check_circle : Icons.cancel,
                color: esExitoso ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  esExitoso
                      ? 'La calificación se ha aprobado exitosamente.'
                      : 'La calificación no se aprobó.',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: docenteNavBar(name ?? '...', storage, context),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 1020;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: isMobile
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildContent(isMobile),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildContent(isMobile),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildContent(bool isMobile) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isMobile ? 300 : 500,
            height: isMobile ? 200 : 350,
            color: const Color.fromARGB(153, 243, 243, 243),
            child: _imagenSeleccionada != null
                ? Image.memory(
                    _imagenSeleccionada!,
                    fit: BoxFit.contain,
                  )
                : const Icon(
                    Icons.image,
                    size: 100,
                    color: Color.fromARGB(255, 115, 115, 115),
                  ),
          ),
        ],
      ),
      const SizedBox(width: 40, height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            competenciaTitulo ?? 'Cargando...',
            style: TextStyle(
                fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            estudianteNombre ?? 'Cargando...',
            style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                color: const Color.fromARGB(255, 227, 227, 227)),
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
                  minimumSize:
                      isMobile ? const Size(100, 40) : const Size(120, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Aprobar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 18,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              ElevatedButton(
                onPressed: () {
                  _updateCalificacion(2);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B2D56),
                  minimumSize:
                      isMobile ? const Size(100, 40) : const Size(120, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'No Aprobar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
