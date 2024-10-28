// Asegúrate de importar las demás páginas necesarias
import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/Calificar/VerCompetenciasAdmin.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/CrearDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/ListaDeDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/registrar_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/vista_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/RegistrarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/Vista_Estudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/Habilitar/VistaInhabilitados.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ListaPendiente/AceptarDocente.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ListaPendiente/AceptarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/MenuAdmin/MenuAdmin.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEstudiante/vista_porFechas.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/ReportesEstudiante/vista_reporte.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/CambiarContrasenia.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';


AppBar adminNavBar(String nombre, Session sesion, BuildContext context) {
  TextStyle commonTextStyle =
      const TextStyle(fontSize: 16, color: Colors.black);

  return AppBar(
    backgroundColor: const Color(0xFF8B2D56),
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuAdmin()),
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
              'Admin Univalle',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        // Botón "Reportes"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'ver_puntos') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VistaReporte()),
              );
            } else if (value == 'ver_fecha') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VistaReporteFecha()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'ver_puntos',
                  child: Text('Ver Puntos', style: commonTextStyle)),
              PopupMenuItem<String>(
                  value: 'ver_fecha',
                  child: Text('Ver Fecha', style: commonTextStyle)),
            ];
          },
          child: Text('Reportes', style: commonTextStyle),
        ),
        const SizedBox(width: 10),
        // Botón "Escuelas"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'lista_escuelas') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VistaEscuela()),
              );
            } else if (value == 'agregar_escuela') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrarEscuela()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'lista_escuelas',
                  child: Text('Lista Escuelas', style: commonTextStyle)),
              PopupMenuItem<String>(
                  value: 'agregar_escuela',
                  child: Text('Agregar Escuelas', style: commonTextStyle)),
            ];
          },
          child: Text('Escuelas', style: commonTextStyle),
        ),
        const SizedBox(width: 10),
        // Botón "Estudiantes"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'lista_estudiantes') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VistaEst()),
              );
            } else if (value == 'agregar_estudiante') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrarEstPage()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'lista_estudiantes',
                  child: Text('Lista Estudiantes', style: commonTextStyle)),
              PopupMenuItem<String>(
                  value: 'agregar_estudiante',
                  child: Text('Agregar Estudiante', style: commonTextStyle)),
            ];
          },
          child: Text('Estudiantes', style: commonTextStyle),
        ),
        const SizedBox(width: 10),
        // Botón "Docentes"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'lista_docentes') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VistaDoce()),
              );
            } else if (value == 'agregar_docente') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrarDocePage()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'lista_docentes',
                  child: Text('Lista Docentes', style: commonTextStyle)),
              PopupMenuItem<String>(
                  value: 'agregar_docente',
                  child: Text('Agregar Docente', style: commonTextStyle)),
            ];
          },
          child: Text('Docentes', style: commonTextStyle),
        ),
        const SizedBox(width: 10),
        // Botón "Listas Pendientes"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'lista_pendiente_docente') {
              // Reemplaza con la ruta de la página que muestra la lista pendiente de docentes
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerificarDoce()),
              );
            } else if (value == 'lista_pendiente_estudiante') {
              // Reemplaza con la ruta de la página que muestra la lista pendiente de estudiantes
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerificarEst()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'lista_pendiente_docente',
                  child:
                      Text('Lista Pendiente Docente', style: commonTextStyle)),
              PopupMenuItem<String>(
                  value: 'lista_pendiente_estudiante',
                  child: Text('Lista Pendiente Estudiante',
                      style: commonTextStyle)),
            ];
          },
          child: Text('Listas Pendientes', style: commonTextStyle),
        ),
        const SizedBox(width: 10),
        // Botón "Calificar"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Calificar') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => verCompetenciaAdmin()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'Calificar',
                  child: Text('Calificar', style: commonTextStyle)),
            ];
          },
          child: Text('Calificar', style: commonTextStyle),
        ),
        const SizedBox(width: 10),
        // Botón "Inhabilitados"
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Inhabilitados') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VistaInhabilitados()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: 'Inhabilitados',
                  child: Text('Inhabilitados', style: commonTextStyle)),
            ];
          },
          child: Text('Inhabilitados', style: commonTextStyle),
        ),
        const SizedBox(width: 25),
        // Botón desplegable de "Cuenta" con el mismo estilo de "Cerrar Sesión"
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
                    builder: (context) =>
                        const CambiarContrasenia()), // Página para cambiar contraseña
              );
            }
          },
          child: ElevatedButton(
            onPressed:
                null, // Hacemos el botón desplegable no clickeable directamente
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(255, 255, 255, 255), // Fondo negro
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
