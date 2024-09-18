import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/MenuAdmin/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/EscuelaService.dart';
import 'package:prlll_24_escuela_programacion/models/Escuela.dart';

void main() {
  runApp(RegistrarEscuela());
}

class RegistrarEscuela extends StatelessWidget {
  const RegistrarEscuela({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrarEscuelaPage(),
    );
  }
}

class RegistrarEscuelaPage extends StatefulWidget {
  const RegistrarEscuelaPage({super.key});

  @override
  _RegistrarEscuelaState createState() => _RegistrarEscuelaState();
}

class _RegistrarEscuelaState extends State<RegistrarEscuelaPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  // Servicio de Usuario
  final EscuelaService _escuelaService = EscuelaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminNavBar("Diego R"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 650),
            padding: const EdgeInsets.all(45),
            decoration: BoxDecoration(
              color: const Color(0xFFE0BFC7),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'REGISTRAR ESCUELA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E244D),
                  ),
                ),
                
                const SizedBox(height: 20),
                buildTextField('Nombre', _nombreController),
                const SizedBox(height: 10),
                buildTextField('Descripcion', _descripcionController),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      // Crear el objeto Usuario
                      NewEscuela nuevaEscuela = NewEscuela(
                          nombre: "${_nombreController.text}",
                          descripcion: "${_descripcionController.text}");

                      // Llamar al método post para enviar el Usuario a la API
                      Escuela escuela =
                          await _escuelaService.post(nuevaEscuela);

                      // Si es exitoso, mostrar un mensaje
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Escuela creada con éxito: ${escuela.id}")),
                      );
                    } catch (e) {
                      // Mostrar mensaje de error en caso de fallo
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error al crear la Escuela")),
                      );
                    }
                  },
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E244D),
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar Volver
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text('Volver',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: const Color(
            0xFFF5E0E5), // Fondo rosado claro en los campos de texto
      ),
    );
  }
}
