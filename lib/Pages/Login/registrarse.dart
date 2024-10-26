// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';

class RegistrarsePage extends StatefulWidget {
  const RegistrarsePage({super.key});

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistrarsePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final UsuariosService _usuarioService = UsuariosService();
  String _rolSeleccionado = 'DOCENTE';

  Future<void> crearUsuario(BuildContext context) async {
    if (_nombreController.text.isEmpty ||
        _correoController.text.isEmpty ||
        _rolSeleccionado.isEmpty) {
      _mostrarDialogoAdvertencia();
      return;
    }

    try {
      NewUsuario nuevoUsuario = NewUsuario(
        nombre: _nombreController.text,
        contrasenia: "prueba",
        correo: _correoController.text,
        rol: _rolSeleccionado == 'DOCENTE' ? 'D' : 'E',
        idUsuario: 2,
        solicitud: 'P',
      );

      Usuario estudiante = await _usuarioService.post(nuevoUsuario);

      _mostrarDialogoExito(estudiante.idUsuario);

      _nombreController.clear();
      _correoController.clear();
      setState(() {
        _rolSeleccionado = 'DOCENTE';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al crear el usuario"),
        ),
      );
    }
  }

  void _mostrarDialogoAdvertencia() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Campos incompletos'),
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 10),
              Expanded(
                child: Text("Por favor, no deje ningún campo vacío."),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Cierra el diálogo
              },
              child: const Text('Cerrar', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoExito(int idUsuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Expanded(
                child: Text("Espere a ser aceptado"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Cierra el diálogo
                Navigator.of(context).pop();  // Regresa a la pantalla anterior
              },
              child: const Text('Cerrar', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'REGISTRARSE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8E244D),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0BFC7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombres',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5E0E5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _correoController,
                          decoration: InputDecoration(
                            labelText: 'Correo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5E0E5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _rolSeleccionado,
                          decoration: InputDecoration(
                            labelText: 'Rol',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5E0E5),
                          ),
                          items: ['DOCENTE', 'ESTUDIANTE'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _rolSeleccionado = newValue!;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Por favor seleccione un rol' : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              crearUsuario(context);
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
                            Navigator.of(context).pop();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
