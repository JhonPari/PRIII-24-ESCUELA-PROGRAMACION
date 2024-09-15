import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Service/usuarios_service.dart';
import 'package:prlll_24_escuela_programacion/models/usuario.dart';


class RegistrarEstPage extends StatefulWidget {
  const RegistrarEstPage({super.key});

  @override
  _RegistrarEstState createState() => _RegistrarEstState();
}

class _RegistrarEstState extends State<RegistrarEstPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final UsuariosService _usuarioService = UsuariosService();
  final _formKey = GlobalKey<FormState>();

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu nombre completo';
    }
    
    // Expresión regular para validar el nombre completo en español
    final nameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚÑáéíóúñ]+([\s-][A-Za-zÁÉÍÓÚÑáéíóúñ]+)+$');
    
    if (!nameRegex.hasMatch(value)) {
      return 'Por favor, ingresa un nombre completo válido (e.g., Juan Pérez)';
    }
    
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa una dirección de correo electrónico';
    }
    
    // Expresión regular para validar el formato del correo electrónico
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, ingresa una dirección de correo electrónico válida';
    }
    
    return null;
  }

  Future<void> crearUsuario(BuildContext context) async {
    try {
      // Crear el objeto Usuario
      // TODO generar contraseña
      NewUsuario nuevoUsuario = NewUsuario(
        nombre: _nombreController.text,
        contrasenia: "prueba",
        correo: _correoController.text,
        rol: 'E',
        idUsuario: 2,
        solicitud: 'A',
      );

      // Llamar al método post para enviar el Usuario a la API
      Usuario estudiante = await _usuarioService.post(nuevoUsuario);

      // Si es exitoso, mostrar un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Usuario creado con éxito: ${estudiante.idUsuario}"
          ),
        ),
      );

      Navigator.of(context).pop();

    } catch (e) {
      // Mostrar mensaje de error en caso de fallo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al crear el usuario"),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'REGISTRAR ESTUDIANTE',
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
                      validator: validateFullName,
                      decoration: InputDecoration(
                        labelText: 'Nombres',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: const Color(
                            0xFFF5E0E5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _correoController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: const Color(
                            0xFFF5E0E5),
                      ),
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
    );
  }
}