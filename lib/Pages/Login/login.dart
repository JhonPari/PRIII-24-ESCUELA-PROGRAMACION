// ignore_for_file: library_private_types_in_public_api, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/MenuAdmin/MenuAdmin.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/MenuDocente.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/registrarse.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/pages/estudiante/menu_est.dart';
import 'package:prlll_24_escuela_programacion/pages/Login/RecuperarPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwController = TextEditingController();
  final UsuariosService _usuarioService = UsuariosService();
  final storage = Session();

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();

    if (data['id'] != null && data['name'] != null && data['role'] != null) {
      redireccionRoles(data['role']!);
    }
  }

  // Método que maneja el inicio de sesión
  Future<void> hacerLogin() async {
    String correo = _correoController.text;
    String passw = _passwController.text;

    Map<String, dynamic>? usuario = await _usuarioService.login(correo, passw);

    if (usuario != null) {
      String id = usuario['id'].toString();
      String name = usuario['name'];
      String role = usuario['role'];

      // Guardar la sesión
      await storage.saveSession(id, name, role);

      redireccionRoles(usuario['role']);
    } else {
      // Mostrar error si el login falla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: correo o contraseña incorrectos')),
      );
    }
  }

  void redireccionRoles(String role) {
    if (role == 'A') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuAdmin()),
      );
    } else if (role == 'D') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuDoce()),
      );
    } else if (role == 'E') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuEst()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/logo_univalle.png',
                    height: 300,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B2D56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _correoController,
                          decoration: InputDecoration(
                            labelText: 'Correo:',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña:',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: hacerLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RecuperarContrasenaPage()),
                                );
                              },
                              child: const Text(
                                'Recuperar contraseña',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RegistrarsePage()),
                                );
                              },
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
