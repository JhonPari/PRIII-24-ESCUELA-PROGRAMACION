import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/CrearDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/EditarDocentes.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';

class VistaDoce extends StatefulWidget {
  const VistaDoce({super.key});

  @override
  State<VistaDoce> createState() => _VistaDoceState();
}

class _VistaDoceState extends State<VistaDoce> {
  UsuariosService usuariosService = UsuariosService();
  late Future<List<Usuario>> _listaUsuarios;

  @override
  void initState() {
    super.initState();
    _listaUsuarios = usuariosService.getDocentes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'LISTA DE DOCENTES',
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
                    MaterialPageRoute(
                      builder: (context) => const RegistrarDocePage(), // Se agregó 'const'
                    ),
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
            Expanded(child: docentesGrid()), // Cambiamos el widget de la tabla
          ],
        ),
      ),
    );
  }

  Widget docentesGrid() {
    return FutureBuilder<List<Usuario>>(
      future: _listaUsuarios,
      builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No hay usuarios',
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          List<Usuario> usuarios = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Número de columnas 
              childAspectRatio: 3 / 2, // Relación de aspecto para que los cuadros se vean como en la imagen
              crossAxisSpacing: 16.0, // Espacio horizontal entre los cuadros
              mainAxisSpacing: 16.0, // Espacio vertical entre los cuadros
            ),
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              Usuario usuario = usuarios[index];
              return Card(
                color: const Color(0xFFE0BFC7), // Color de fondo del cuadro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usuario.nombre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Descripcion siuu',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarDocePage(idUsuario: usuario.id!),
                                ),
                              );
                            },
                            icon: const Icon(Icons.sync, color: Colors.white),
                            label: const Text(
                              'Modificar',
                              style: TextStyle(color: Colors.white),
                            ),
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
                            label: const Text(
                              'Eliminar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E244D),
                              minimumSize: const Size(100, 30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
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
                Navigator.of(context).pop();
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
}
