// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

void main() => runApp(const VerificarEst());

class VerificarEst extends StatefulWidget {
  const VerificarEst({super.key});

  @override
  State<VerificarEst> createState() => _VerificarEstState();
}

class _VerificarEstState extends State<VerificarEst> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<Usuario>> _listaUsuarios;
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _listaUsuarios = usuariosService.getListaPendienteEstudiante();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    if (data['name'] != null) {
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: adminNavBar(name ?? '...', storage, context),
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
      ),
    );
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
                color: const Color(0xFFE0BFC7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                                  label: const Text('Aceptar',
                                      style: TextStyle(color: Colors.white)),
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
                                  label: const Text('Rechazar',
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
              const Text('¿Estás seguro de que deseas rechazar este usuario?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();
                  await usuariosService.deleteLogic(id);
                  _mostrarDialogoExito(
                      'Rechazado exitosa', 'Usuario Rechazado correctamente.');
                  setState(() {
                    _listaUsuarios =
                        usuariosService.getListaPendienteEstudiante();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Error al rechazar el usuario.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E244D),
              ),
              child:
                  const Text('Rechazar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void mostrarConfirmacionVerificacion(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar aceptación'),
          content:
              const Text('¿Estás seguro de que deseas aceptar esta solicitud?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();
                  Usuario usuario = await usuariosService.get(id);
                  usuario.solicitud = 'A';
                  await usuariosService.putAceptarSolicitud(id, usuario);
                  _mostrarDialogoExito('Aceptación exitosa',
                      'Solicitud aceptada correctamente.');
                  setState(() {
                    _listaUsuarios =
                        usuariosService.getListaPendienteEstudiante();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Error al aceptar la solicitud del usuario.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child:
                  const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoExito(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
