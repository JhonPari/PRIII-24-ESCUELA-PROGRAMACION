import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrarDocentePage(),
    );
  }
}

class RegistrarDocentePage extends StatefulWidget {
  @override
  _RegistrarDocentePageState createState() => _RegistrarDocentePageState();
}

class _RegistrarDocentePageState extends State<RegistrarDocentePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo_univalle.png', height: 50),
            SizedBox(width: 10), // Espacio entre logo y nombre
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Karen Poma", style: TextStyle(fontSize: 16)),
                Text("Univalle", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF8E244D), // Color personalizado
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Reportes', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Calificaciones', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Escuelas', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Estudiantes', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Docentes', style: TextStyle(color: Colors.white)),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'REGISTRAR DOCENTE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E244D),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFE0BFC7), // Color de fondo rosado
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    buildTextField('Nombre', 'Value'),
                    SizedBox(height: 10),
                    buildTextField('Apellidos', 'Value'),
                    SizedBox(height: 10),
                    buildTextField('Correo', 'Value'),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Acción al presionar Aceptar
                      },
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8E244D),
                        minimumSize: Size(double.infinity, 40),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Acción al presionar Volver
                      },
                      child: Text('Volver', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        minimumSize: Size(double.infinity, 40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String hintText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Color(0xFFF5E0E5), // Fondo rosado claro en los campos de texto
      ),
    );
  }
}
