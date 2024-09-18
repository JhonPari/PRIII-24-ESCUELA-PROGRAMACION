import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Service/EscuelaService.dart';
import 'package:prlll_24_escuela_programacion/models/Escuela.dart';

class EditEscuelaPage extends StatefulWidget {
  final int idescuela;

  const EditEscuelaPage({Key? key, required this.idescuela}) : super(key: key);

  @override
  _EditEscuelaPageState createState() => _EditEscuelaPageState();
}

class _EditEscuelaPageState extends State<EditEscuelaPage> {
  late TextEditingController _nombreController = TextEditingController();
  late TextEditingController _descripcionController = TextEditingController();
  final EscuelaService _escuelaService = EscuelaService();
  final _formKey = GlobalKey<FormState>();
  late Escuela? _escuela; // Cambiado para permitir valores nulos

  @override
  void initState() {
    super.initState();
    _cargarEscuela();
  }

  void _cargarEscuela() async {
    Escuela? escuela = await _escuelaService.get(widget.idescuela);
    setState(() {
      _escuela = escuela;
      if (_escuela != null) {
        _nombreController.text = _escuela!.nombre;
        _descripcionController.text = _escuela!.descripcion;
      } else {
        //TODO cerrar esta ventana
      }
    });
  }

  Future<void> actualizarEscuela(BuildContext context) async {
    try {
      if (_escuela != null) {
        _escuela!.nombre = _nombreController.text;
        _escuela!.descripcion = _descripcionController.text;

        await _escuelaService.put(widget.idescuela, _escuela!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Escuela actualizada con éxito")),
        );

        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al actualizar la escuela")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'MODIFICAR ESCUELA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8E244D),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0BFC7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5E0E5),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descripcionController,
                        decoration: InputDecoration(
                          labelText: 'Descripcion',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5E0E5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            actualizarEscuela(context);
                          }
                        },
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text(
                          'Aceptar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8E244D),
                          minimumSize: const Size(double.infinity, 40),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        child: const Text('Volver',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
