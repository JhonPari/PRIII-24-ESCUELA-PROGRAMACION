// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/CambiarContrasenia.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';

import 'package:prlll_24_escuela_programacion/Service/session.dart';

AppBar NavBarMenus(String nombre, Session sesion, BuildContext context) {
  TextStyle commonTextStyle =
      const TextStyle(fontSize: 16, color: Colors.black);

  return AppBar(
    automaticallyImplyLeading: false,
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
              'Univalle',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        // Botón desplegable de "Cuenta" con el mismo estilo de "Cerrar Sesión"
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'Cerrar Sesión') {
              await sesion.removeSession();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }  else if (value == 'Cambiar Contraseña') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CambiarContrasenia()), // Página para cambiar contraseña
              );
            }
          },
          child: ElevatedButton(
            onPressed:
                null, // Hacemos el botón desplegable no clickeable directamente
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Fondo negro
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Bordes redondeados
              ),
            ),
            child: const Text(
              'Cuenta',
              style: TextStyle(
                  color: Colors.white, fontSize: 16), // Texto en blanco
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'Cerrar Sesión',
                child: Text('Cerrar Sesión'),
              ),
              const PopupMenuItem<String>(
                value: 'Cambiar Contraseña',
                child: Text('Cambiar Contraseña'),
              ),
            ];
          },
        ),
      ],
    ),
  );
}
