import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/Calificar/VerCompetenciasAdmin.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/CrearDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/ListaDeDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/registrar_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/vista_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/RegistrarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/Vista_Estudiante.dart';
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
      const TextStyle(fontSize: 16, color: Colors.white);

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFF8B2D56),
    title: LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 800;

        return Row(
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
            if (!isSmallScreen)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre,
                      style: commonTextStyle.copyWith(color: Colors.white70)),
                  const Text(
                    'Admin Univalle',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            const Spacer(),
            if (!isSmallScreen)
              Row(
                children: [
                  // Reportes
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'ver_puntos') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VistaReporte()));
                      } else if (value == 'ver_fecha') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VistaReporteFecha()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'ver_puntos',
                          child: Text('Ver Puntos',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                      PopupMenuItem(
                          value: 'ver_fecha',
                          child: Text('Ver Fecha',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                    ],
                    child: Text('Reportes', style: commonTextStyle),
                  ),
                  const SizedBox(width: 10),

                  // Escuelas
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'lista_escuelas') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VistaEscuela()));
                      } else if (value == 'agregar_escuela') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrarEscuela()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'lista_escuelas',
                          child: Text('Lista Escuelas',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                      PopupMenuItem(
                          value: 'agregar_escuela',
                          child: Text('Agregar Escuelas',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                    ],
                    child: Text('Escuelas', style: commonTextStyle),
                  ),
                  const SizedBox(width: 10),

                  // Estudiantes
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'lista_estudiantes') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VistaEst()));
                      } else if (value == 'agregar_estudiante') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrarEstPage()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'lista_estudiantes',
                          child: Text('Lista Estudiantes',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                      PopupMenuItem(
                          value: 'agregar_estudiante',
                          child: Text('Agregar Estudiante',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                    ],
                    child: Text('Estudiantes', style: commonTextStyle),
                  ),
                  const SizedBox(width: 10),

                  // Docentes
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'lista_docentes') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VistaDoce()));
                      } else if (value == 'agregar_docente') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrarDocePage()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'lista_docentes',
                          child: Text('Lista Docentes',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                      PopupMenuItem(
                          value: 'agregar_docente',
                          child: Text('Agregar Docente',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                    ],
                    child: Text('Docentes', style: commonTextStyle),
                  ),
                  const SizedBox(width: 10),

                  // Listas Pendientes
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'lista_pendiente_docente') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VerificarDoce()));
                      } else if (value == 'lista_pendiente_estudiante') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VerificarEst()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'lista_pendiente_docente',
                          child: Text('Lista Pendiente Docente',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                      PopupMenuItem(
                          value: 'lista_pendiente_estudiante',
                          child: Text('Lista Pendiente Estudiante',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                    ],
                    child: Text('Listas Pendientes', style: commonTextStyle),
                  ),
                  const SizedBox(width: 10),

                  // Calificar
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Calificar') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => verCompetenciaAdmin()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'Calificar',
                          child: Text('Calificar',
                              style: commonTextStyle.copyWith(
                                  color: Colors.black))),
                    ],
                    child: Text('Calificar', style: commonTextStyle),
                  ),
                  const SizedBox(width: 25),
                ],
              )
            else
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'reportes') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VistaReporte()),
                    );
                  } else if (value == 'escuelas') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VistaEscuela()),
                    );
                  } else if (value == 'estudiantes') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VistaEst()),
                    );
                  } else if (value == 'docentes') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VistaDoce()),
                    );
                  } else if (value == 'pendientes') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerificarDoce()),
                    );
                  } else if (value == 'calificar') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => verCompetenciaAdmin()),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 'reportes',
                      child: Text('Reportes',
                          style: commonTextStyle.copyWith(color: Colors.black))),
                  PopupMenuItem(
                      value: 'escuelas',
                      child: Text('Escuelas',
                          style: commonTextStyle.copyWith(color: Colors.black))),
                  PopupMenuItem(
                      value: 'estudiantes',
                      child: Text('Estudiantes',
                          style: commonTextStyle.copyWith(color: Colors.black))),
                  PopupMenuItem(
                      value: 'docentes',
                      child: Text('Docentes',
                          style: commonTextStyle.copyWith(color: Colors.black))),
                  PopupMenuItem(
                      value: 'pendientes',
                      child: Text('Pendientes',
                          style: commonTextStyle.copyWith(color: Colors.black))),
                  PopupMenuItem(
                      value: 'calificar',
                      child: Text('Calificar',
                          style: commonTextStyle.copyWith(color: Colors.black))),
                ],
                child: const Icon(Icons.menu),
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
        );
      },
    ),
  );
}
