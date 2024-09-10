import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Models/usuario.dart';

class RegistrarDocentePage extends StatefulWidget {
  @override
  _RegistrarDocentePageState createState() => _RegistrarDocentePageState();
}

class _RegistrarDocentePageState extends State<RegistrarDocentePage> {
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contraseniaController = TextEditingController();

  // URL de tu API
  final String apiUrl = 'https://localhost:7096/swagger/v1/swagger.json';

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
                Text("Karen Poma", style: TextStyle(fontSize: 16)),
                Text("Univalle", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF8E244D),
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
              buildTextField('Nombre', _nombreController),
              SizedBox(height: 10),
              buildTextField('Correo', _correoController),
              SizedBox(height: 10),
              buildTextField('Contraseña', _contraseniaController,
                  isPassword: true),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  Usuario nuevoUsuario = Usuario(
                    id: 0, // Será generado por la API
                    nombre: _nombreController.text,
                    contrasenia: _contraseniaController.text,
                    correo: _correoController.text,
                    rol: 'docente',
                    idUsuario: 1, // Puedes ajustar este valor
                    fechaRegistro: DateTime.now(),
                    estado: 'activo',
                    solicitud: 'pendiente',
                  );

                  await nuevoUsuario.registrarUsuario(apiUrl);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Docente registrado exitosamente')),
                  );
                },
                icon: Icon(Icons.check, color: Colors.white),
                label: Text('Aceptar', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Color(0xFFF5E0E5),
      ),
    );
  }
}
