// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prlll_24_escuela_programacion/Models/SubirImagen.dart';
import 'package:prlll_24_escuela_programacion/Pages/Login/login.dart';
import 'package:prlll_24_escuela_programacion/Pages/Navbar/est_navbar.dart';
import 'package:prlll_24_escuela_programacion/Service/ImagenesService.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart';

class EntregarPrueba extends StatefulWidget {
  final int idCompetencia;
  const EntregarPrueba({super.key, required this.idCompetencia});

  @override
  _EntregarPrueba createState() => _EntregarPrueba();
}

class _EntregarPrueba extends State<EntregarPrueba> {
  Uint8List? _webImage;
  late String extensionn;
  bool _isLoading = false;

  final storage = Session();
  String? name;
  int id = 0;

  ImagenesService service = ImagenesService();

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    // Obtiene el mapa con los datos de la sesión
    Map<String, String?> data = await storage.getSession();

    if (data['id'] == null || data['name'] == null || data['role'] == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      //if del rol
    } else {
      setState(() {
        name = data['name'] ?? 'Sin Nombre';
        id = int.parse(data['id']!);
      });
    }
  }

  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true; // Mostrar indicador de carga
    });

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();

        setState(() {
          _webImage = bytes;
          _isLoading = false;
          extensionn = pickedFile.name;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: estNavBar(name ?? '...', storage, context, id),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_webImage != null)
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: const Color.fromARGB(153, 243, 243, 243),
                  width: 350,
                  height: 200,
                  child: _webImage != null
                      ? Image.memory(_webImage!)
                      : const Icon(
                          Icons.image,
                          size: 100,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Subir Foto',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _webImage == null ? null : _confirmSubmission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirmar entrega',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmSubmission() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content:
              const Text("¿Estás seguro de que quieres confirmar la entrega?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                SubirImagen subida = SubirImagen(
                    idCompetencia: widget.idCompetencia,
                    idEstudiante: id,
                    imagen: _webImage!,
                    nombre: extensionn);

                bool guardado = await service.subirImagen(subida);

                Navigator.of(context).pop();

                if (guardado) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Entrega confirmada")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al subir la imagen")),
                  );
                }
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }
}
