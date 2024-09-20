import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/EditarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEstudiante/RegistrarEstudiante.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart'; // Importa el adminNavBar
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
    _listaUsuarios = usuariosService.getEstudiantes();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    setState(() {
      name = data['name'] ?? 'Sin Nombre';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: adminNavBar(name ?? '...', storage, context), // Usa el adminNavBar aquí
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrarEstPage()),
                    );
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
              Expanded(child: TablaEst()),
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
                color: const Color(0xFFE0BFC7), // Fondo rosado para la tabla
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Para scroll horizontal si es necesario
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
                          const DataCell(Text("0")), // TODO recibir puntos
                          DataCell(
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditarEstPage(idUsuario: usuario.id!)),
                                    );
                                  },
                                  icon: const Icon(Icons.sync, color: Colors.white),
                                  label: const Text('Modificar', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    minimumSize: const Size(100, 30),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    mostrarDialogoConfirmacion(context, usuario.id!);
                                  },
                                  icon: const Icon(Icons.cancel, color: Colors.white),
                                  label: const Text('Eliminar', style: TextStyle(color: Colors.white)),
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
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este usuario?'),
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
                      content: Text('Usuario eliminado exitosamente.'),
                    ),
                  );
                  setState(() {
                    _listaUsuarios = usuariosService.getEstudiantes();
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
                backgroundColor: const Color(0xFF8E244D), // Color del botón de confirmación
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
}
