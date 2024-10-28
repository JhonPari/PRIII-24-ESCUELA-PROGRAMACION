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

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu nombre completo';
    }
    final nameRegex =
        RegExp(r'^[A-Za-zÁÉÍÓÚÑáéíóúñ]+([\s-][A-Za-zÁÉÍÓÚÑáéíóúñ]+)+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Por favor, ingresa un nombre completo válido (e.g., Juan Pérez)';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa una dirección de correo electrónico';
    }
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, ingresa una dirección de correo electrónico válida';
    }
    return null;
  }

  Future<void> crearUsuario(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        NewUsuario nuevoUsuario = NewUsuario(
          nombre: _nombreController.text,
          contrasenia: "prueba",
          correo: _correoController.text,
          rol: _rolSeleccionado == 'DOCENTE' ? 'D' : 'E',
          idUsuario: 1,
          solicitud: 'P',
        );
        Usuario usu = await _usuarioService.post(nuevoUsuario);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registro exitoso'),
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text('Usuario creado con éxito.'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _nombreController.clear();
                    _correoController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        String errorMessage = "Error al crear el usuario";
        if (e.toString().contains("El correo ya está en uso")) {
          errorMessage = "El correo ya está en uso. Intente con otro.";
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error en el registro'),
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(errorMessage),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _nombreController.clear();
                    _correoController.clear();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
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
                          validator: validateFullName,
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
                          validator: validateEmail,
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
                            crearUsuario(context);
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
