// ignore_for_file: use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/Calificar/EstudianteCompetenciaAdmin.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/competenciaDoceService.dart';
import 'package:prlll_24_escuela_programacion/models/Competencia.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';


void main() {
  runApp(verCompetenciaAdminPage());
}

class verCompetenciaAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: verCompetenciaAdmin(),
      theme: ThemeData(
        primaryColor: const Color(0xFF8E244D),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF8E244D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class verCompetenciaAdmin extends StatefulWidget {
  @override
  _verCompetenciaAdminState createState() => _verCompetenciaAdminState();
}

class _verCompetenciaAdminState extends State<verCompetenciaAdmin> {
  final CompetenciaDoceService competenciaService = CompetenciaDoceService();
  final Session storage = Session();
  String? name;
  int id = 0;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    if (data['name'] != null) {
      setState(() {
        name = data['name'];
        id = int.parse(data['id']!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminNavBar (name ?? '...', storage, context), // Uso del navbar existente
      body: FutureBuilder<List<Competencia>>(
        future: competenciaService.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay competencias disponibles.'));
          }

          List<Competencia> competencias = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: competencias.map((competencia) {
                return CompetenciaCard(
                  id: competencia.id,
                  titulo: competencia.titulo ?? 'Sin título',
                  descripcion:
                      competencia.descripcion ?? 'No hay una descripcion',
                  fechaInicio: competencia.fechaInicio != null
                      ? '${competencia.fechaInicio!.day}/${competencia.fechaInicio!.month}/${competencia.fechaInicio!.year}'
                      : 'N/A',
                  fechaFin: competencia.fechaFin != null
                      ? '${competencia.fechaFin!.day}/${competencia.fechaFin!.month}/${competencia.fechaFin!.year}'
                      : 'N/A',
                  estado: 'En Curso', // Ajusta según tu lógica
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class CompetenciaCard extends StatelessWidget {
  final int id;
  final String titulo;
  final String descripcion;
  final String fechaInicio;
  final String fechaFin;
  final String estado;

  const CompetenciaCard({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Descripcion: $descripcion'),
          Text('Fecha de Inicio: $fechaInicio'),
          Text('Fecha de Finalización: $fechaFin'),
          Text('Estado: $estado'),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                print('El id es: $id');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompetenciaAdminPage(idCompetencia: id)),
                );
              },
              child: const Text('Calificar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E244D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
