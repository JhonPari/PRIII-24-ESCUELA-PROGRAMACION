import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EstudiantesCompetenciaPage(),
    );
  }
}

class EstudiantesCompetenciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LISTA DE ESTUDIANTES EN X COMPETENCIA'),
        backgroundColor: Color(0xFF8E244D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterButton(text: 'Aceptado'),
                FilterButton(text: 'Pendiente'),
                FilterButton(text: 'Reprobado'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nombres, Apellidos o Correos',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Lógica de búsqueda
                  },
                  child: Text('Buscar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Cambia esto a la cantidad de estudiantes
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Diego Adrian Ricaldez'),
                    subtitle: Text('jan123@'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Lógica de evaluación
                      },
                      child: Text('Evaluar'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            PaginationWidget(),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;

  FilterButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: BorderSide(color: Color(0xFF8E244D)),
      ),
    );
  }
}

class PaginationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        Text('1'),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
      ],
    );
  }
}
