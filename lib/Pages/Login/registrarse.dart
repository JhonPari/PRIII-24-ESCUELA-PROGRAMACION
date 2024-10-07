import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';

class RegistrarsePage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistrarsePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final UsuariosService _usuarioService = UsuariosService();
  String _rolSeleccionado = 'DOCENTE';

  Future<void> crearUsuario(BuildContext context) async {
    try {
      NewUsuario nuevoUsuario = NewUsuario(
        nombre: _nombreController.text,
        contrasenia: "prueba",
        correo: _correoController.text,
        rol: _rolSeleccionado == 'DOCENTE' ? 'D' : 'E',
        idUsuario: 2,
        solicitud: 'P',
      );

      Usuario estudiante = await _usuarioService.post(nuevoUsuario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario creado con éxito: ${estudiante.idUsuario}"),
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al crear el usuario"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints:
                BoxConstraints(maxWidth: 600), 
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'REGISTRARSE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8E244D),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0BFC7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombres',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5E0E5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _correoController,
                          decoration: InputDecoration(
                            labelText: 'Correo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5E0E5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _rolSeleccionado,
                          decoration: InputDecoration(
                            labelText: 'Rol',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5E0E5),
                          ),
                          items: ['DOCENTE', 'ESTUDIANTE'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _rolSeleccionado = newValue!;
                            });
                          },
                          validator: (value) => value == null
                              ? 'Por favor seleccione un rol'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              crearUsuario(context);
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
      ),
    );
  }
}
