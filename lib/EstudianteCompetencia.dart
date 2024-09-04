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
            _buildFilterButtons(),
            SizedBox(height: 20),
            _buildSearchField(),
            SizedBox(height: 20),
            _buildStudentList(),
            SizedBox(height: 20),
            PaginationWidget(),
          ],
        ),
      ),
    );
  }

  // Widget para los botones de filtro
  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterButton(text: 'Aceptado'),
        SizedBox(width: 10),
        FilterButton(text: 'Pendiente'),
        SizedBox(width: 10),
        FilterButton(text: 'Reprobado'),
      ],
    );
  }

  // Widget para el campo de búsqueda
  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Nombres, Apellidos o Correos',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // Lógica de búsqueda
          },
          child: Text('Buscar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF8E244D), // Se cambió a backgroundColor
          ),
        ),
      ],
    );
  }

  // Widget para la lista de estudiantes
  Widget _buildStudentList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 3, // Cambia esto según la cantidad de estudiantes
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('Diego Adrian Ricaldez'),
              subtitle: Text('jan123@correo.com'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Lógica de evaluación
                },
                child: Text('Evaluar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8E244D), // Se cambió a backgroundColor
                ),
              ),
            ),
          );
        },
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
      onPressed: () {
        // Lógica del filtro
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: BorderSide(color: Color(0xFF8E244D)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
        IconButton(
          onPressed: () {
            // Acción para ir a la página anterior
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF8E244D),
        ),
        Text('1'), // Cambia el número según la página actual
        IconButton(
          onPressed: () {
            // Acción para ir a la página siguiente
          },
          icon: Icon(Icons.arrow_forward),
          color: Color(0xFF8E244D),
        ),
      ],
    );
  }
}
