// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/vista_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Service/EscuelaService.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/models/Escuela.dart';

void main() {
  runApp(const RegistrarEscuela());
}

class RegistrarEscuela extends StatelessWidget {
  const RegistrarEscuela({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  final EscuelaService _escuelaService = EscuelaService();
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminNavBar(name ?? '...', storage, context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 650),
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
                buildTextField('Descripción', _descripcionController),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_nombreController.text.isEmpty ||
                        _descripcionController.text.isEmpty) {
                      // Mostrar cuadro de diálogo de error si los campos están vacíos
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error en el registro'),
                            content: const Row(
                              children: [
                                Icon(Icons.error,
                                    color: Colors.red), // Ícono de error
                                SizedBox(width: 10),
                                Text('Por favor, completa todos los campos.'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Cerrar el cuadro de diálogo
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // Salir si hay un error
                    }

                    try {
                      NewEscuela nuevaEscuela = NewEscuela(
                        nombre: _nombreController.text,
                        descripcion: _descripcionController.text,
                      );

                      Escuela escuela =
                          await _escuelaService.post(nuevaEscuela);

                      // Mostrar cuadro de diálogo de éxito
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Registro exitoso'),
                            content: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 10),
                                Text('Escuela registrada correctamente'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Cerrar el cuadro de diálogo
                                  // Redirigir a VistaEscuela
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VistaEscuela()),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Error al crear la Escuela")),
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
                    Navigator.of(context).pop(); // Regresar
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
