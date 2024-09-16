import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Admin/CrudDocente/CrearDocentes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrarDocePage()
    );
  }
}
