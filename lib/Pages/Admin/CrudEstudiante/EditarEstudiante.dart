// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/Vista_Estudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class EditarEstPage extends StatefulWidget {
  final int idUsuario; // Recibe el id del usuario

  const EditarEstPage(
      {super.key, required this.idUsuario}); // Constructor con id

  @override
  _EditarEstState createState() => _EditarEstState();
}

class _EditarEstState extends State<EditarEstPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final UsuariosService _usuarioService = UsuariosService();
  final _formKey = GlobalKey<FormState>();
  late Usuario? _usuario; // Cambiado para permitir valores nulos
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
    _loadSession();
  }

  void _cargarUsuario() async {
    Usuario? usuario = await _usuarioService.get(widget.idUsuario);
    setState(() {
      _usuario = usuario;
      if (_usuario != null) {
        _nombreController.text = _usuario!.nombre;
        _correoController.text = _usuario!.correo;
      }
    });
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    if (data['name'] != null) {
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
      });
    }
  }

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

  Future<void> actualizarUsuario(BuildContext context) async {
    try {
      if (_usuario != null) {
        _usuario!.nombre = _nombreController.text;
        _usuario!.correo = _correoController.text;

        await _usuarioService.put(widget.idUsuario, _usuario!);

        // Mostrar cuadro de diálogo de éxito
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Modificación exitosa'),
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text('Estudiante modificado correctamente'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                    // Redirigir a ListaDeEstudiantes
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const VistaEst()), // Redirigir a ListaDeEstudiantes
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al actualizar el usuario")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminNavBar(
          name ?? '...', storage, context), // Usa el navbar de AdminNavBar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'MODIFICAR ESTUDIANTE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E244D),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
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
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          actualizarUsuario(context);
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
    );
  }
}
