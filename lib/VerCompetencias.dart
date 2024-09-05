import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF8E244D), // Color del AppBar
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF8E244D), // Color de los botones
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo_univalle.png', height: 50),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Karen Poma',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Estudiante Univalle',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Lógica para cerrar sesión
            },
            child: Text('Cerrar Sesión'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ],
        backgroundColor: Color(0xFF8E244D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CompetenciaCard(
              titulo: 'Hakaton',
              fechaInicio: '20/09/2024',
              fechaFin: '20/10/2024',
              estado: 'En Curso',
            ),
            CompetenciaCard(
              titulo: 'GameJam',
              fechaInicio: '20/09/2024',
              fechaFin: '20/10/2024',
              estado: 'Finalizado',
            ),
          ],
        ),
      ),
    );
  }
}

class CompetenciaCard extends StatelessWidget {
  final String titulo;
  final String fechaInicio;
  final String fechaFin;
  final String estado;

  CompetenciaCard({
    required this.titulo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200, // Ajusta el tamaño de los cuadros
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
          Text(
            titulo,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Fecha de Inicio: $fechaInicio'),
          Text('Fecha de Finalización: $fechaFin'),
          Text('Estado: $estado'),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Lógica del botón Calificar
              },
              child: Text('Calificar'),
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
