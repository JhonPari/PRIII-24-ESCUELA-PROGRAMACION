import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/MenuDocente.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/VerCompetencias.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/vistaDoce_reportes/vistaDoce_porFechas.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/vistaDoce_reportes/vistaDoce_porPuntos.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/CambiarContrasenia.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

AppBar docenteNavBar(String nombre, Session sesion, BuildContext context) {
  // Definir un estilo de texto común
  TextStyle commonTextStyle =
      const TextStyle(fontSize: 16, color: Colors.black);

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFF8B2D56),
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MenuDoce()), // Navegar a la página MenuDoce
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
              'Docente Univalle',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        // Competencias
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'competencias') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerCompetenciaDoce()),
              );
            }
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
        // Reportes
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'reporte_puntos':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VistaDoceReporte()),
                );
                break;
              case 'reporte_fechas':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VistaDoceReporteFecha()),
                );
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'reporte_puntos',
                child: Text('Reporte por Puntos', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'reporte_fechas',
                child: Text('Reporte por Fechas', style: commonTextStyle),
              ),
            ];
          },
          child: Text(
            'Reportes',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 25),
        // Botón desplegable de "Cuenta"
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
                MaterialPageRoute(
                    builder: (context) => const CambiarContrasenia()),
              );
            }
          },
          child: ElevatedButton(
            onPressed: null, // Hacemos el botón desplegable no clickeable directamente
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Cuenta',
              style: TextStyle(
                  color: Colors.white, fontSize: 14
                  ), // Texto en blanco
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
