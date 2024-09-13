import 'package:flutter/material.dart';

import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';


void main() => runApp(const VerificarDoce());

class VerificarDoce extends StatefulWidget {
  const VerificarDoce({super.key});

  @override
  State<VerificarDoce> createState() => _VerificarDoceState();
}

class _VerificarDoceState extends State<VerificarDoce> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<Usuario>> _listaUsuarios;

  @override
  void initState() {
    super.initState();
    _listaUsuarios = usuariosService.getListaPendienteDocente();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'LISTA DE ESTUDIANTES PENDIENTES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E244D),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
            ),
            const SizedBox(height: 15),
            TablaEst(),
          ],
        ),
      ),
    ));
  }

  Expanded TablaEst() {
    return Expanded(
      child: FutureBuilder<List<Usuario>>(
        future: _listaUsuarios,
        builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay usuarios', style: TextStyle(fontSize: 18)));
          } else {
            List<Usuario> usuarios = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0BFC7), // Fondo rosado para la tabla
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Para scroll horizontal si es necesario
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nombres')),
                      DataColumn(label: Text('Correo')),
                      DataColumn(label: Text('Acciones')),
                    ],
                    rows: usuarios.map((usuario) {
                      return DataRow(
                        cells: [
                          DataCell(Text(usuario.nombre)),
                          DataCell(Text(usuario.correo)),
                          DataCell(
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    mostrarConfirmacionVerificacion(
                                        context, usuario.id!);
                                  },
                                  icon: const Icon(Icons.check,
                                      color: Colors.white),
                                  label: const Text('Modificar',
                                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50),
                                    minimumSize: const Size(100, 30),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    mostrarDialogoConfirmacion(
                                        context, usuario.id!);
                                  },
                                  icon: const Icon(Icons.cancel,
                                      color: Colors.white),
                                  label: const Text('Eliminar',
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8E244D),
                                    minimumSize: const Size(100, 30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
  
  void mostrarDialogoConfirmacion(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Rechazo de Solicitud'),
          content:
              const Text('¿Estás seguro de que deseas Rechazar este usuario?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();

                  await usuariosService.deleteLogic(id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario Rechazado exitosamente.'),
                    ),
                  );

                  setState(() {
                    _listaUsuarios = usuariosService.getListaPendienteDocente();
                  });

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error al eliminar el usuario."),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF8E244D), // Color del botón de confirmación
              ),
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
//aceptar solicitud
  void mostrarConfirmacionVerificacion(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar aceptación'),
        content: const Text('¿Estás seguro de que deseas aceptar esta solicitud?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                Navigator.of(context).pop();

                Usuario usuario = await usuariosService.get(id);
                usuario.solicitud = 'A'; // Actualiza la solicitud del usuario

                await usuariosService.putAceptarSolicitud(id, usuario);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Solicitud aceptada exitosamente.'),
                  ),
                );

                setState(() {
                  // Actualiza la lista de usuarios pendientes (puedes ajustar según tu necesidad)
                  _listaUsuarios = usuariosService.getListaPendienteDocente();
                });

              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error al aceptar la solicitud del usuario."),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8E244D), // Color del botón de confirmación
            ),
            child: const Text(
              'Aceptar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

  
  
}
