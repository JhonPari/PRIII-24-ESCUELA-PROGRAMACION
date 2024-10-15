import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/EstCompetencias.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/menu_est.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/verLogros.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/pages/Login/login.dart';


AppBar estNavBar(String nombre, Session sesion, BuildContext context, int id) {
  return AppBar(
    backgroundColor: const Color(0xFF8B2D56),
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuEst ()), // Redirige al menú de estudiante
            );
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo_univalle.png'),
            radius: 20,
          ),
        ),
        const SizedBox(width: 10),
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
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerLogrosPage(idEst: id)),
            );
          },
          child: const Text(
            'Ver Logros',
            style: TextStyle(color: Colors.black),
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
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            await sesion.removeSession();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners
            ),
          ),
          child: const Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
