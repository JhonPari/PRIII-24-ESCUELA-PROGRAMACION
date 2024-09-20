import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart'; 
import 'package:prlll_24_escuela_programacion/Service/session.dart';

AppBar NavBarMenus(String nombre, Session sesion, BuildContext context) {
  TextStyle commonTextStyle = const TextStyle(fontSize: 16, color: Colors.black);

  return AppBar(
    backgroundColor: const Color(0xFF8B2D56),
    title: Row(
      children: [
        // Logo Univalle
        GestureDetector(
          onTap: () {
            // Aquí puedes agregar la acción que quieres al hacer clic en el logo
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo_univalle.png'),
            radius: 20,
          ),
        ),
        const SizedBox(width: 10),
        // Nombre del usuario y su rol
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: commonTextStyle.copyWith(color: Colors.white38),
            ),
            const Text(
              'Estudiante Univalle',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        // Botón de Cerrar Sesión
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
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
