// ignore_for_file: deprecated_member_use

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/ReporteEscuelaEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEstudiante/vista_porFechas.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEstudiante/vista_reporte.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;

void main() => runApp(const VistaReporteEscuela());

class VistaReporteEscuela extends StatefulWidget {
  const VistaReporteEscuela({super.key});

  @override
  State<VistaReporteEscuela> createState() => _VistaReporteEscuelaState();
}

class _VistaReporteEscuelaState extends State<VistaReporteEscuela> {
  final UsuariosService usuariosService = UsuariosService();
  late Future<List<ReporteEscuelaEstudiante>> _listaReportes;
  final Session storage = Session();
  String? name;

  List<String> opciones = [
    'Ver Reportes por Puntos',
    'Ver Reportes por Fechas',
    'Ver Reporte de Escuelas', // Nueva opción añadida
  ];
  String? opcionSeleccionada;

  // Variable para el término de búsqueda
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadSession();
    _fetchReportes(); // Carga los reportes al inicio
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    setState(() {
      name = data['name'] ?? 'Sin Nombre'; // Valor por defecto si 'name' es null
    });
  }

  Future<void> _fetchReportes() async {
    _listaReportes = usuariosService.getReportesEscuelaEstudiante();
  }

  Future<void> _exportToExcel(List<ReporteEscuelaEstudiante> reportes) async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Reporte'];

    sheet.appendRow(['Nombre Escuela', 'Título Competencia', 'Nombre Estudiante', 'Correo Estudiante']);
    for (var reporte in reportes) {
      sheet.appendRow([
        reporte.nombreEscuela,
        reporte.tituloCompetencia,
        reporte.nombreEstudiante,
        reporte.correoEstudiante,
      ]);
    }

    var excelBytes = excel.encode();
    final content = base64Encode(excelBytes!);
    // ignore: unused_local_variable
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;base64,$content")
      ..setAttribute("download", "ReporteEscuelas.xlsx")
      ..click();
  }

  Future<void> _exportToPdf(List<ReporteEscuelaEstudiante> reportes) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Reporte de Escuelas', style: const pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  headers: ['Nombre Escuela', 'Título Competencia', 'Nombre Estudiante', 'Correo Estudiante'],
                  data: reportes.map((e) => [
                    e.nombreEscuela,
                    e.tituloCompetencia,
                    e.nombreEstudiante,
                    e.correoEstudiante,
                  ]).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    // ignore: unused_local_variable
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "ReporteEscuelas.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  void _navegar() {
    if (opcionSeleccionada == 'Ver Reportes por Puntos') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VistaReporte()),
      );
    } else if (opcionSeleccionada == 'Ver Reportes por Fechas') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VistaReporteFecha()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: adminNavBar(name ?? '...', storage, context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'REPORTE DE ESCUELAS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E244D),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de búsqueda
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Buscar por Nombre Escuela o Competencia',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // DropdownButton para seleccionar opciones
              DropdownButton<String>(
                hint: const Text('Seleccione un Reporte'),
                value: opcionSeleccionada,
                onChanged: (String? newValue) {
                  setState(() {
                    opcionSeleccionada = newValue;
                  });
                  _navegar();
                },
                items: opciones.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),
              _buildExportButtons(),
              const SizedBox(height: 20),
              Expanded(child: _buildReportTable()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExportButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            List<ReporteEscuelaEstudiante> reportes = await _listaReportes;
            _exportToExcel(reportes);
          },
          icon: const Icon(Icons.download, color: Colors.white),
          label: const Text('Exportar a Excel'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () async {
            List<ReporteEscuelaEstudiante> reportes = await _listaReportes;
            _exportToPdf(reportes);
          },
          icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
          label: const Text('Exportar a PDF'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildReportTable() {
  return FutureBuilder<List<ReporteEscuelaEstudiante>>(
    future: _listaReportes,
    builder: (BuildContext context, AsyncSnapshot<List<ReporteEscuelaEstudiante>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text('No hay reportes disponibles', style: TextStyle(fontSize: 18)),
        );
      } else {
        List<ReporteEscuelaEstudiante> reportes = snapshot.data!;
        
        // Filtrar los reportes según el término de búsqueda
        List<ReporteEscuelaEstudiante> filteredReportes = reportes.where((reporte) {
          return reporte.nombreEscuela.toLowerCase().contains(_searchTerm.toLowerCase()) ||
                 reporte.tituloCompetencia.toLowerCase().contains(_searchTerm.toLowerCase());
        }).toList();

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE0BFC7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Habilita el desplazamiento horizontal
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre Escuela')),
                  DataColumn(label: Text('Título Competencia')),
                  DataColumn(label: Text('Nombre Estudiante')),
                  DataColumn(label: Text('Correo Estudiante')),
                ],
                rows: filteredReportes.map((reporte) {
                  return DataRow(
                    cells: [
                      DataCell(Text(reporte.nombreEscuela)),
                      DataCell(Text(reporte.tituloCompetencia)),
                      DataCell(Text(reporte.nombreEstudiante)),
                      DataCell(Text(reporte.correoEstudiante)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }
    },
  );
}

}
