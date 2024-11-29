import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/EstCompetencias.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/menu_est.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/verLogros.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/CambiarContrasenia.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';

AppBar estNavBar(String nombre, Session sesion, BuildContext context, int id) {
  TextStyle commonTextStyle = const TextStyle(fontSize: 16, color: Colors.white);

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFF8B2D56),
    title: LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuEst()),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo_univalle.png'),
                radius: 20,
              ),
            ),
            const SizedBox(width: 10),
            if (constraints.maxWidth > 600)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                  const Text(
                    'Estudiante Univalle',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            const Spacer(),
            Wrap(
              spacing: 10,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerLogrosPage(idEst: id)),
                    );
                  },
                  child: const Text(
                    'Ver Logros',
                    style: TextStyle(color: Colors.white), // Texto blanco
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EstCompetenciaPage()),
                    );
                  },
                  child: const Text(
                    'Competencias Inscritas',
                    style: TextStyle(color: Colors.white), // Texto blanco
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'Cerrar Sesión') {
                      await sesion.removeSession();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    } else if (value == 'Cambiar Contraseña') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CambiarContrasenia()),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cuenta',
                      style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'Cerrar Sesión',
                        child: Text('Cerrar Sesión', style: TextStyle(color: Colors.black)),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Cambiar Contraseña',
                        child: Text('Cambiar Contraseña', style: TextStyle(color: Colors.black)),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
