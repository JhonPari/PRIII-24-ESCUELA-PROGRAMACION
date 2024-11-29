import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/Models/usuario.dart';

void main() => runApp(const VistaInhabilitados());

class VistaInhabilitados extends StatefulWidget {
  const VistaInhabilitados({super.key});

  @override
  _InhabilitadosState createState() => _InhabilitadosState();
}

class _InhabilitadosState extends State<VistaInhabilitados> {
  final UsuariosService _usuariosService = UsuariosService();
  final Session storage = Session();
  List<Usuario> _usuarios = [];
  List<Usuario> _usuariosFiltrados = [];
  bool _isLoading = true;
  String? _filtroRol;
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _fetchUsuariosInhabilitados();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
      });
    }
  }

  Future<void> _fetchUsuariosInhabilitados() async {
    try {
      _usuarios = await _usuariosService.getUsuariosEstadoE();
      _usuariosFiltrados = _usuarios;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar usuarios: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _habilitarUsuario(int id) async {
    try {
      await _usuariosService.cambiarEstadoA(id);
      _showSuccessDialog();
      _fetchUsuariosInhabilitados();
    } catch (e) {
      _showErrorDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              const Text('Usuario habilitado exitosamente.'),
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

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 10),
              const Text('No se pudo habilitar el usuario.'),
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

  void _showConfirmDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Habilitación'),
          content:
              const Text('¿Estás seguro de que deseas habilitar este usuario?'),
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
                await _habilitarUsuario(id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text(
                'Habilitar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUsuarioDetails(Usuario usuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(usuario.nombre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Correo: ${usuario.correo}"),
              Text("Rol: ${_mapRol(usuario.rol)}"),
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

  String _mapRol(String? rol) {
    switch (rol) {
      case 'A':
        return 'Administrador';
      case 'E':
        return 'Estudiante';
      case 'D':
        return 'Docente';
      default:
        return 'Rol desconocido';
    }
  }

  void _filterUsuarios() {
    setState(() {
      if (_filtroRol == null || _filtroRol == 'Todos') {
        _usuariosFiltrados = _usuarios;
      } else {
        String? rolFiltrado;
        if (_filtroRol == 'Administrador') {
          rolFiltrado = 'A';
        } else if (_filtroRol == 'Estudiante') {
          rolFiltrado = 'E';
        } else if (_filtroRol == 'Docente') {
          rolFiltrado = 'D';
        }

        _usuariosFiltrados =
            _usuarios.where((usuario) => usuario.rol == rolFiltrado).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminNavBar(name ?? '...', storage, context),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Lista de Usuarios Inhabilitados',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8E244D),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: _filtroRol,
                  hint: const Text("Filtrar por rol"),
                  items: <String>[
                    'Todos',
                    'Administrador',
                    'Estudiante',
                    'Docente'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _filtroRol = newValue;
                      _filterUsuarios();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio:
                          5, 
                      mainAxisSpacing: 10, 
                      crossAxisSpacing: 10, 
                    ),
                    itemCount: _usuariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = _usuariosFiltrados[index];
                      return Card(
                        color: const Color(0xFFE0BFC7), // Establece el color de fondo de la tarjeta
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 7,
                          ),
                          title: Text(
                            usuario.nombre,
                            
                             style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () => _showUsuarioDetails(usuario),
                          trailing: ElevatedButton(
                            onPressed: () => _showConfirmDialog(context, usuario.id!),
                            child: const Text(
                              "Habilitar",
                              style: TextStyle(fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                              backgroundColor: const Color(0xFF8E244D),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      );

                    },
                  ),
          ),
        ],
      ),
    );
  }
}
