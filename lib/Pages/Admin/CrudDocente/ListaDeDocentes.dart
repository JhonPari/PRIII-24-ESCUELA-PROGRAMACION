import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/CrearDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudDocente/EditarDocentes.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Models/usuario.dart';

class VistaDoce extends StatefulWidget {
  const VistaDoce({super.key});

  @override
  State<VistaDoce> createState() => _VistaDoceState();
}

class _VistaDoceState extends State<VistaDoce> {
  final storage = Session();
  String? name;
  UsuariosService usuariosService = UsuariosService();
  late Future<List<Usuario>> _listaUsuarios;

  @override
  void initState() {
    super.initState();
    _loadSession(); // Verifica la sesión del usuario
    _loadDocentes(); // Carga la lista de docentes
  }

  Future<void> _loadDocentes() async {
    setState(() {
      _listaUsuarios = usuariosService.getDocentes();
    });
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();

    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacementNamed(context, '/login'); // Redirige a login si no hay sesión
    } else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre'; // Establece el nombre del usuario
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminNavBar(name ?? '...', storage, context), // Navegación
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'LISTA DE DOCENTES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E244D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrarDocePage(),
                    ),
                  );
                  _loadDocentes(); // Recarga la lista después de añadir un docente
                },
                icon: const Icon(Icons.person_add, color: Colors.white),
                label: const Text('Añadir'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                  minimumSize: const Size(80, 30), // Tamaño mínimo del botón
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espaciado interno
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(child: docentesGrid()), // Carga la cuadrícula de docentes
          ],
        ),
      ),
    );
  }

  Widget docentesGrid() {
    return FutureBuilder<List<Usuario>>(
      future: _listaUsuarios, // Espera a que se carguen los usuarios
      builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Muestra indicador de carga
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Manejo de errores
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateGridColumns(context), // Calcula el número de columnas
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              Usuario usuario = usuarios[index];
              return Card(
                color: const Color(0xFFE0BFC7),
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
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditarDocePage(idUsuario: usuario.id!),
                                ),
                              );

                              // Verifica si se ha actualizado el usuario
                              if (result == true) {
                                setState(() {
                                  _listaUsuarios = usuariosService.getDocentes();
                                });
                              }
                            },
                            icon: const Icon(Icons.sync, color: Colors.white),
                            label: const Text(
                              'Modificar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              minimumSize: const Size(80, 30), // Tamaño mínimo del botón
                              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espaciado interno
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              mostrarDialogoConfirmacion(usuario.id!);
                            },
                            icon: const Icon(Icons.cancel, color: Colors.white),
                            label: const Text(
                              'Eliminar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E244D),
                              minimumSize: const Size(80, 30), // Tamaño mínimo del botón
                              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espaciado interno
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

  int _calculateGridColumns(BuildContext context) {
    // Calcula el número de columnas basado en el ancho de la pantalla
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 1; // Pantallas pequeñas (móviles)
    } else if (width < 900) {
      return 2; // Pantallas medianas (tabletas)
    } else {
      return 3; // Pantallas grandes (computadoras)
    }
  }

  void mostrarDialogoConfirmacion(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Expanded(child: Text('¿Estás seguro de que deseas eliminar este usuario?')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop(); // Cierra el diálogo

                  await usuariosService.deleteLogic(id); // Lógica de eliminación

                  // Mostrar el diálogo de éxito
                  mostrarDialogoExito(); // Llama al diálogo de éxito

                  setState(() {
                    _listaUsuarios = usuariosService.getDocentes(); // Actualiza la lista
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

  void mostrarDialogoExito() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Expanded(child: Text('El usuario ha sido eliminado exitosamente.')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
