// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/EditarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/RegistrarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

void main() => runApp(const VistaEst());

class VistaEst extends StatefulWidget {
  const VistaEst({super.key});

  @override
  State<VistaEst> createState() => _VistaEstState();
}

class _VistaEstState extends State<VistaEst> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<Usuario>> _listaUsuarios;
  final Session storage = Session();
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _loadUsuarios();
  }

  Future<void> _loadUsuarios() async {
    setState(() {
      _listaUsuarios = usuariosService.getEstudiantes();
    });
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    setState(() {
      name = data['name'] ?? 'Sin Nombre';
    });
  }

  Future<void> _deleteEstudiante(int id) async {
    try {
      await usuariosService.deleteLogic(id);
      _loadUsuarios();
      _showSuccessDialog();
    } catch (e) {
      print('Error al eliminar el estudiante: $e');
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
                'LISTA DE ESTUDIANTES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8E244D),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrarEstPage()),
                    );
                    if (mounted) {
                      _loadUsuarios();
                    }
                  },
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  label: const Text('Añadir'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(child: _buildStudentTable()),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildStudentTable() {
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
                  DataColumn(label: Text('Puntos')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: usuarios.map((usuario) {
                  return DataRow(
                    cells: [
                      DataCell(Text(usuario.nombre)),
                      DataCell(Text(usuario.correo)),
                      const DataCell(Text("0")),
                      DataCell(
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditarEstPage(idUsuario: usuario.id!),
                                  ),
                                );
                                if (mounted) {
                                  _loadUsuarios();
                                }
                              },
                              icon: const Icon(Icons.sync, color: Colors.white),
                              label: const Text('Modificar',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                minimumSize: const Size(100, 30),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                _showDeleteConfirmationDialog(usuario.id!);
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
  );
}


  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar este estudiante?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                _deleteEstudiante(id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E244D),
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminación Exitosa'),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 24),
              SizedBox(width: 10),
              Expanded(child: Text('El estudiante se eliminó exitosamente.')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
