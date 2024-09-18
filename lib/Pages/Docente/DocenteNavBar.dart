import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Estudiante/menu_est.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

AppBar docenteNavBar(String nombre, Session sesion, BuildContext context) {
  // Definir un estilo de texto común
  TextStyle commonTextStyle = const TextStyle(fontSize: 16, color: Colors.black);

  return AppBar(
    backgroundColor: const Color(0xFF8B2D56),
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuEst()), // Navegar a la página MenuEst
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
              style: commonTextStyle.copyWith(color: Colors.white38),
            ),
            const Text(
              'Estudiante Univalle',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Manejar la acción seleccionada
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'competencias',
                child: Text('Competencias', style: commonTextStyle),
              ),
            ];
          },
          child: Text(
            'Competencias',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Manejar la acción seleccionada
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'lista_Estudiantes',
                child: Text('Lista Estudiantes', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'agregar_estudiante',
                child: Text('Agregar Estudiante', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'solicitud',
                child: Text('Ver Solicitudes', style: commonTextStyle),
              ),
            ];
          },
          child: Text(
            'Estudiantes',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 25),
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
