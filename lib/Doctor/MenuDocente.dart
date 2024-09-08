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
        title: Image.asset('assets/images/logo_univalle.png', height: 50),
        actions: [
          DropdownButton(
            icon: Icon(Icons.people, color: Color(0xFF8E244D)),
            items: [
              DropdownMenuItem(child: Text('Estudiantes')),
            ],
            onChanged: (value) {},
          ),
          DropdownButton(
            icon: Icon(Icons.assessment, color: Color(0xFF8E244D)),
            items: [
              DropdownMenuItem(child: Text('Competencias')),
            ],
            onChanged: (value) {},
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para cerrar sesión
            },
            child: Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ],
        backgroundColor: Color(0xFF8E244D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar Competencias
                },
                child: Text('Competencias'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 80,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Estudiantes'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar Ver Reportes
                },
                child: Text('Ver Reportes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
