// ignore_for_file: avoid_web_libraries_in_flutter, unused_local_variable, deprecated_member_use

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/ReporteFechas.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEscuela/ReportesEscuelaEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEstudiante/vista_reporte.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;

void main() => runApp(const VistaReporteFecha());

class VistaReporteFecha extends StatefulWidget {
  const VistaReporteFecha({super.key});

  @override
  State<VistaReporteFecha> createState() => _VistaReportState();
}

class _VistaReportState extends State<VistaReporteFecha> {
  final UsuariosService usuariosService = UsuariosService();
  late Future<List<ReporteEstudianteFecha>> _listaReportes;
  List<ReporteEstudianteFecha> allReportes = []; // Para almacenar todos los reportes
  final Session storage = Session();
  String? name;

  // Variables para seleccionar las fechas
  DateTime? startDate;
  DateTime? endDate;

  // Lista de opciones para el menú desplegable
  List<String> opciones = [
    'Ver Reportes por Puntos',
    'Ver Reportes por Fechas',
    'Ver Reporte de Escuelas',
  ];
  String? opcionSeleccionada;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _fetchReportes(); // Cargar reportes al inicio
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    setState(() {
      name = data['name'] ?? 'Sin Nombre';
    });
  }

  Future<void> _fetchReportes() async {
    _listaReportes = usuariosService.getReportEstudiantesFecha().then((reportes) {
      allReportes = reportes; // Almacenar todos los reportes
      return reportes;
    });
  }

  Future<void> _exportToExcel(List<ReporteEstudianteFecha> reportes) async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Reporte'];

    sheet.appendRow(['Nombres', 'Correo', 'Puntos', 'Fecha de Inicio']);

    for (var reporte in reportes) {
      sheet.appendRow([
        reporte.nombre,
        reporte.correo,
        reporte.puntos.toString(),
        reporte.fechaInicioCompetencia.toString().split(' ')[0], // Formatear la fecha
      ]);
    }

    var excelBytes = excel.encode();
    final content = base64Encode(excelBytes!);
    final anchor = html.AnchorElement(href: "data:application/octet-stream;base64,$content")
      ..setAttribute("download", "ReporteEstudiantes.xlsx")
      ..click();
  }

  Future<void> _exportToPdf(List<ReporteEstudianteFecha> reportes) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Reporte de Estudiantes', style: const pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  headers: ['Nombres', 'Correo', 'Puntos', 'Fecha de Inicio'],
                  data: reportes.map((e) => [
                    e.nombre,
                    e.correo,
                    e.puntos.toString(),
                    e.fechaInicioCompetencia.toString().split(' ')[0], // Formatear la fecha
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
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "ReporteEstudiantes.pdf")
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
    } else if (opcionSeleccionada == 'Ver Reporte de Escuelas') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VistaReporteEscuela()),
      );
    }
  }

  void _filterByDate() {
    // Filtrar la lista de reportes
    setState(() {
      if (startDate != null && endDate != null) {
        _listaReportes = Future.value(allReportes.where((reporte) {
          final fecha = reporte.fechaInicioCompetencia;
          return fecha.isAfter(startDate!) && fecha.isBefore(endDate!);
        }).toList());
      } else {
        _listaReportes = Future.value(allReportes); // Mostrar todos si no hay rango
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: adminNavBar(name ?? '...', storage, context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'REPORTE DE ESTUDIANTES POR FECHAS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E244D),
                  ),
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
                    _navegar(); // Navegar al seleccionar una opción
                  },
                  items: opciones.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Selectores de fecha
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: startDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            startDate = date;
                          });
                        }
                      },
                      child: Text(startDate == null ? 'Seleccionar Fecha Inicio' : 'Inicio: ${startDate!.toLocal()}'.split(' ')[0]),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: endDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            endDate = date;
                          });
                        }
                      },
                      child: Text(endDate == null ? 'Seleccionar Fecha Fin' : 'Fin: ${endDate!.toLocal()}'.split(' ')[0]),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _filterByDate,
                  child: const Text('Filtrar por Fecha'),
                ),

                const SizedBox(height: 20),
                _buildExportButtons(),
                const SizedBox(height: 20),
                Expanded(child: _buildReportTable()),
              ],
            ),
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
          onPressed: () => _listaReportes.then((reportes) => _exportToExcel(reportes)),
          icon: const Icon(Icons.download, color: Colors.white),
          label: const Text('Exportar a Excel'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () => _listaReportes.then((reportes) => _exportToPdf(reportes)),
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
    return FutureBuilder<List<ReporteEstudianteFecha>>(
      future: _listaReportes,
      builder: (BuildContext context, AsyncSnapshot<List<ReporteEstudianteFecha>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay estudiantes', style: TextStyle(fontSize: 18)),
          );
        } else {
          List<ReporteEstudianteFecha> reportes = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE0BFC7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombres')),
                  DataColumn(label: Text('Correo')),
                  DataColumn(label: Text('Puntos')),
                  DataColumn(label: Text('Fecha de Inicio')),
                ],
                rows: reportes.map((reporte) {
                  return DataRow(
                    cells: [
                      DataCell(Text(reporte.nombre)),
                      DataCell(Text(reporte.correo)),
                      DataCell(Text(reporte.puntos.toString())),
                      DataCell(Text(reporte.fechaInicioCompetencia.toString().split(' ')[0])), // Formatear la fecha
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
