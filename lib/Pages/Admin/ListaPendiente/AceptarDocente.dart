 // ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Models/usuario.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

void main() => runApp(const VerificarDoce());

class VerificarDoce extends StatefulWidget {
  const VerificarDoce({super.key});

  @override
  State<VerificarDoce> createState() => _VerificarDoceState();
}

class _VerificarDoceState extends State<VerificarDoce> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<Usuario>> _listaUsuarios;
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _listaUsuarios = usuariosService.getListaPendienteDocente();
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
                'LISTA DE DOCENTES PENDIENTES',
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
              Expanded(child: TablaEst()),
            ],
          ),
        ),
      ),
    );
  }

Widget TablaEst() {
  return FutureBuilder<List<Usuario>>(
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
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => const Color.fromRGBO(232, 188, 196, 1), // Color del encabezado
                  ),
                  dataRowColor: MaterialStateProperty.resolveWith(
                    (states) => const Color.fromRGBO(232, 188, 196, 1), // Color de las filas
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Nombres',
                        style: TextStyle(color: Colors.black), // Texto en blanco
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Correo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Acciones',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                  rows: usuarios.map((usuario) {
                    return DataRow(
                      cells: [
                        DataCell(Text(usuario.nombre)),
                        DataCell(Text(usuario.correo)),
                        DataCell(
                          constraints.maxWidth < 600
                              ? Wrap(
                                  spacing: 8,
                                  children: [
                                    _buildActionButton(
                                        context, usuario.id!, 'Aceptar', Icons.check, Colors.green, true),
                                    _buildActionButton(
                                        context, usuario.id!, 'Eliminar', Icons.cancel, Colors.red, false),
                                  ],
                                )
                              : Row(
                                  children: [
                                    _buildActionButton(
                                        context, usuario.id!, 'Aceptar', Icons.check, Colors.green, true),
                                    const SizedBox(width: 10),
                                    _buildActionButton(
                                        context, usuario.id!, 'Eliminar', Icons.cancel, Colors.red, false),
                                  ],
                                ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      }
    },
  );
}



  Widget _buildActionButton(BuildContext context, int id, String label, IconData icon, Color color, bool isAccept) {
    return ElevatedButton.icon(
      onPressed: () {
        if (isAccept) {
          mostrarConfirmacionVerificacion(context, id);
        } else {
          mostrarDialogoConfirmacion(context, id);
        }
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(100, 30),
      ),
    );
  }

  Future<void> _actualizarListaUsuarios() async {
    setState(() {
      _listaUsuarios = usuariosService.getListaPendienteDocente();
    });
  }

  void mostrarDialogoConfirmacion(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Rechazo de Solicitud'),
          content: const Text('¿Estás seguro de que deseas rechazar este usuario?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await usuariosService.deleteFisic(id);
                  _actualizarListaUsuarios(); 
                  _mostrarDialogoExito(
                    'Rechazo exitoso',
                    'Usuario rechazado correctamente.',
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al rechazar el usuario.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E244D),
              ),
              child: const Text('Rechazar', style: TextStyle(color: Colors.white)),
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
                _actualizarListaUsuarios(); 
              },
              child: const Text('Cerrar'),
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
          content: const Text('¿Estás seguro de que deseas aceptar esta solicitud?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();
                  Usuario usuario = await usuariosService.get(id);
                  usuario.solicitud = 'A';
                  await usuariosService.putAceptarSolicitud(id, usuario);
                  _mostrarDialogoExito(
                    'Aceptación exitosa',
                    'Solicitud aceptada correctamente.',
                  );
                  _actualizarListaUsuarios();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al aceptar la solicitud del usuario.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
} 