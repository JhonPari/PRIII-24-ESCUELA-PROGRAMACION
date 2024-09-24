import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/Reportes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/RegistrarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

void main() => runApp(const VistaReporte());

class VistaReporte extends StatefulWidget {
  const VistaReporte({super.key});

  @override
  State<VistaReporte> createState() => _VistaReportState();
}

class _VistaReportState extends State<VistaReporte> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<ReporteEstudiante>> _listaReportes; // Cambiar el tipo a ReporteEstudiante
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _listaReportes = usuariosService.getReportEstudiantes(); // Asegúrate de que este método esté implementado correctamente
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    setState(() {
      name = data['name'] ?? 'Sin Nombre';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: adminNavBar(name ?? '...', storage, context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'REPORTE DE ESTUDIANTES POR PUNTOS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E244D),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrarEstPage()),
                    );
                  },
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  label: const Text('Añadir'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(child: TablaEst()),
            ],
          ),
        ),
      ),
    );
  }

  Expanded TablaEst() {
    return Expanded(
      child: FutureBuilder<List<ReporteEstudiante>>(
        future: _listaReportes,
        builder: (BuildContext context, AsyncSnapshot<List<ReporteEstudiante>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay estudiantes', style: TextStyle(fontSize: 18)),
            );
          } else {
            List<ReporteEstudiante> reportes = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0BFC7), // Fondo rosado para la tabla
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nombres')),
                      DataColumn(label: Text('Correo')),
                      DataColumn(label: Text('Puntos')),
                    ],
                    rows: reportes.map((reporte) {
                      return DataRow(
                        cells: [
                          DataCell(Text(reporte.nombre)),
                          DataCell(Text(reporte.correo)),
                          DataCell(Text(reporte.puntos.toString())),
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
