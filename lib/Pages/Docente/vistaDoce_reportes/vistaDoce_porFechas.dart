// ignore_for_file: avoid_web_libraries_in_flutter, unused_local_variable, deprecated_member_use

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/Reportes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/DocenteNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;

void main() => runApp(const VistaDoceReporteFecha());

class VistaDoceReporteFecha extends StatefulWidget {
  const VistaDoceReporteFecha({super.key});

  @override
  State<VistaDoceReporteFecha> createState() => _VistaReportState();
}

class _VistaReportState extends State<VistaDoceReporteFecha> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<ReporteEstudiante>> _listaReportes;
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _listaReportes = usuariosService.getReportEstudiantes();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    setState(() {
      name = data['name'] ?? 'Sin Nombre';
    });
  }

  Future<void> _exportToExcel(List<ReporteEstudiante> reportes) async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Reporte'];

    sheet.appendRow(['Nombres', 'Correo', 'Puntos']);

    for (var reporte in reportes) {
      sheet.appendRow([reporte.nombre, reporte.correo, reporte.puntos.toString()]);
    }

    var excelBytes = excel.encode();
    final content = base64Encode(excelBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;base64,$content")
      ..setAttribute("download", "ReporteEstudiantes.xlsx")
      ..click();
  }

  Future<void> _exportToPdf(List<ReporteEstudiante> reportes) async {
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
                  headers: ['Nombres', 'Correo', 'Puntos'],
                  data: reportes
                      .map((e) => [e.nombre, e.correo, e.puntos.toString()])
                      .toList(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: docenteNavBar(name ?? '...', storage, context),
        body: Center(  // Centra el contenido de la pantalla
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // Centra verticalmente los elementos
              children: [
                const Text(
                  'REPORTE DE ESTUDIANTES POR PUNTOS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E244D),
                  ),
                ),
                const SizedBox(height: 20),
                _buildExportButtons(),  // Los botones de exportación
                const SizedBox(height: 20),
                Expanded(child: _buildReportTable()),  // La tabla expandida con el espacio restante
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
    return FutureBuilder<List<ReporteEstudiante>>(
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
          );
        }
      },
    );
  }
}
