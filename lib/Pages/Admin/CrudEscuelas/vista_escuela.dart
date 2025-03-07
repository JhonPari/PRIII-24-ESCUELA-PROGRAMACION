import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/Modificar_Escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Admin/CrudEscuelas/registrar_escuela.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/AdminNavBar.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Service/EscuelaService.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';
import 'package:prlll_24_escuela_programacion/Models/Escuela.dart';

void main() => runApp(const VistaEscuela());

class VistaEscuela extends StatefulWidget {
  const VistaEscuela({super.key});

  @override
  State<VistaEscuela> createState() => _VistaEscuelaState();
}

class _VistaEscuelaState extends State<VistaEscuela> {
  final storage = Session();
  String? name;
  EscuelaService escuelaService = EscuelaService();
  late Future<List<Escuela>> _listaEscuelas;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _loadEscuelas();
  }

  Future<void> _loadEscuelas() async {
    setState(() {
      _listaEscuelas = escuelaService.getAll();
    });
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();

    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return MaterialApp(
      home: Scaffold(
        appBar: adminNavBar(name ?? '...', storage, context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'LISTA ESCUELA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E244D),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistrarEscuelaPage(),
                      ),
                    );
                    _loadEscuelas();
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Añadir Escuela'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF8E244D),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<Escuela>>(
                  future: _listaEscuelas,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Escuela>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No hay Escuelas',
                            style: TextStyle(fontSize: 18)),
                      );
                    } else {
                      List<Escuela> escuelas = snapshot.data!;
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return ListView.separated(
                            itemCount: escuelas.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              Escuela escuela = escuelas[index];
                              return Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: isSmallScreen ? double.infinity : 400,
                                  child: Card(
                                    color: const Color(0xFFB1778E),
                                    elevation: 4.0,
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Container(
                                      height: 140,
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(escuela.nombre,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          const SizedBox(height: 8.0),
                                          Text(escuela.descripcion,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 72, 6, 6))),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  _confirmDelete(context, escuela);
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  side: const BorderSide(
                                                      color: Colors.black),
                                                ),
                                                child: const Text('Eliminar'),
                                              ),
                                              const SizedBox(width: 8.0),
                                              TextButton(
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditEscuelaPage(
                                                              idescuela:
                                                                  escuela.id),
                                                    ),
                                                  );
                                                  _loadEscuelas();
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Colors.black),
                                                ),
                                                child: const Text('Modificar'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteEscuela(int id) async {
    try {
      await escuelaService.deleteLogic(id);
      _loadEscuelas();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Eliminación exitosa'),
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Expanded(child: Text('La escuela se eliminó correctamente.')),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error al eliminar la escuela: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al eliminar la escuela."),
        ),
      );
    }
  }

  void _confirmDelete(BuildContext context, Escuela escuela) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Expanded(child: Text('¿Estás seguro de que deseas eliminar esta escuela?')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Eliminar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E244D),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEscuela(escuela.id);
              },
            ),
          ],
        );
      },
    );
  }
}
