// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';

class CambiarContrasenia extends StatefulWidget {
  const CambiarContrasenia({super.key});

  @override
  _CambiarContraseniaPageState createState() => _CambiarContraseniaPageState();
}

class _CambiarContraseniaPageState extends State<CambiarContrasenia> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final UsuariosService _usuariosService = UsuariosService();

  bool _isLoading = false;

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        bool result = await _usuariosService.changePassword(
          _correoController.text,
          _currentPasswordController.text,
          _newPasswordController.text,
        );

        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseña actualizada con éxito.')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Datos invalidos")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            decoration: BoxDecoration(
              color: const Color(0xFFE0BFC7),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cambiar Contraseña',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 139, 45, 86),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _correoController,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _currentPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña Actual',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña actual';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Nueva Contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nueva contraseña';
                      } else if (value.length < 8 ||
                          !value.contains(RegExp(r'[A-Z]')) ||
                          !value.contains(RegExp(r'[0-9]')) ||
                          !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'La nueva contraseña debe tener al menos 8 caracteres, incluyendo un número, una letra mayúscula y un signo especial';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _changePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(132, 41, 76, 100),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Cambiar Contraseña',
                            style: TextStyle(color: Colors.white),
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
