import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/DocenteNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/competenciaDoceService.dart';
import 'package:prlll_24_escuela_programacion/Models/Competencia.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/EstudianteCompetencia.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class VerCompetenciaDocePage extends StatelessWidget {
  const VerCompetenciaDocePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const VerCompetenciaDoce(),
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

class VerCompetenciaDoce extends StatefulWidget {
  const VerCompetenciaDoce({super.key});

  @override
  VerCompetenciaDoceState createState() => VerCompetenciaDoceState();
}

class VerCompetenciaDoceState extends State<VerCompetenciaDoce> {
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
      appBar: docenteNavBar(name ?? '...', storage, context),
      body: FutureBuilder<List<Competencia>>(
        future: competenciaService.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay competencias disponibles.'));
          }

          List<Competencia> competencias = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1400
                  ? 3
                  : constraints.maxWidth > 800
                      ? 2
                      : 1;
              return GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: competencias.length,
                itemBuilder: (context, index) {
                  var competencia = competencias[index];
                  return CompetenciaCard(
                    id: competencia.id,
                    titulo: competencia.titulo ?? 'Sin título',
                    descripcion:
                        competencia.descripcion ?? 'No hay una descripción',
                    fechaInicio: competencia.fechaInicio != null
                        ? '${competencia.fechaInicio!.day}/${competencia.fechaInicio!.month}/${competencia.fechaInicio!.year}'
                        : 'N/A',
                    fechaFin: competencia.fechaFin != null
                        ? '${competencia.fechaFin!.day}/${competencia.fechaFin!.month}/${competencia.fechaFin!.year}'
                        : 'N/A',
                    estado: 'En Curso',
                  );
                },
              );
            },
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
    super.key,
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
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Descripción: $descripcion'),
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
                      builder: (context) => CompetenciaPage(idCompetencia: id)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E244D),
              ),
              child: const Text('Calificar',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
