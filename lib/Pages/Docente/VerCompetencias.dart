import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/DocenteNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/CompetenciasService.dart';
import 'package:prlll_24_escuela_programacion/Service/competenciaDoceService.dart';
import 'package:prlll_24_escuela_programacion/models/Competencia.dart';
import 'package:prlll_24_escuela_programacion/pages/docente/EstudianteCompetencia.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/est_navbar.dart';

void main() {
  runApp(verCompetenciaDocePage());
}

class verCompetenciaDocePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: verCompetenciaDoce(),
      theme: ThemeData(
        primaryColor: Color(0xFF8E244D),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF8E244D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class verCompetenciaDoce extends StatefulWidget {
  @override
  _verCompetenciaDoceState createState() => _verCompetenciaDoceState();
}

class _verCompetenciaDoceState extends State<verCompetenciaDoce> {
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
      appBar: docenteNavBar (name ?? '...', storage, context), // Uso del navbar existente
      body: FutureBuilder<List<Competencia>>(
        future: competenciaService.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay competencias disponibles.'));
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

  CompetenciaCard({
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Descripcion: $descripcion'),
          Text('Fecha de Inicio: $fechaInicio'),
          Text('Fecha de Finalización: $fechaFin'),
          Text('Estado: $estado'),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                print('El id es: $id');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompetenciaPage(idCompetencia: id)),
                );
              },
              child: Text('Calificar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8E244D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
