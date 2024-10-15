// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/CompetenciaEst.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/entregar_prueba.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/est_navbar.dart';
import 'package:prlll_24_escuela_programacion/Service/CompetenciasService.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class EstCompetenciaPage extends StatefulWidget {
  const EstCompetenciaPage({super.key});

  @override
  State<EstCompetenciaPage> createState() => _EstCompetenciaPageState();
}

class _EstCompetenciaPageState extends State<EstCompetenciaPage> {
  final storage = Session();
  final CompetenciasService service = CompetenciasService();
  String? name;
  int id = 0;
  late Future<List<CompetenciaEst>> competencias;

  @override
  void initState() {
    super.initState();
    _loadSession();
    competencias = service.getCompetenciasEstudiante(id);
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();

    if (data['name'] != null) {
      setState(() {
        name = data['name']!;
        id = int.parse(data['id']!);
        competencias = service.getCompetenciasEstudiante(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: estNavBar(name ?? '...', storage, context, id),
      body: FutureBuilder<List<CompetenciaEst>>(
        future: competencias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay competencias disponibles.'));
          }

          final competenciasData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Cambia según el diseño deseado
                childAspectRatio: 1, // Ajusta el aspecto de las tarjetas
              ),
              itemCount: competenciasData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CompetenciaCard(comp: competenciasData[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CompetenciaCard extends StatefulWidget {
  final CompetenciaEst comp;
  const CompetenciaCard({super.key, required this.comp});

  @override
  State<CompetenciaCard> createState() => _CompetenciaCardState();
}

class _CompetenciaCardState extends State<CompetenciaCard> {
  String FechaCompleta(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200, // Ajusta el tamaño de los cuadros
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
          Text(
            widget.comp.titulo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Fecha de Inicio: ${FechaCompleta(widget.comp.fechaInicio)}'),
          Text('Fecha de Finalización: ${FechaCompleta(widget.comp.fechaFin)}'),
          Text(() {
            switch (widget.comp.estado) {
              case 'A':
                return "Estado: Pendiente";
              case 'F':
                return "Estado: Finalizado";
              case 'C':
                return "Estado: Cancelado";
              default:
                return "Estado: Desconocido";
            }
          }()),
          const SizedBox(height: 20),
          if (widget.comp.estado == 'A')
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EntregarPrueba(idCompetencia: widget.comp.id)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E244D),
                ),
                child: const Text('Revisar',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}
