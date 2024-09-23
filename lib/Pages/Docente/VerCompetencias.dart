import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/DocenteNavBar.dart'; // Importa el docenteNavBar
import 'package:prlll_24_escuela_programacion/Service/session.dart'; // Importa el servicio de sesión
import 'package:prlll_24_escuela_programacion/pages/docente/EstudianteCompetencia.dart'; // Importa la página CompetenciaPage

void main() {
  runApp(VerCompetencias());
}

class VerCompetencias extends StatelessWidget {
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = Session(); // Instancia de Session
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession(); // Cargar la sesión del usuario
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    if (data['name'] != null) {
      setState(() {
        name = data['name']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: docenteNavBar(name ?? '...', storage, context), // Usa el docenteNavBar
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompetenciaPage()),
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
