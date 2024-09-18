import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Pages/Docente/DocenteNavBar.dart';
import 'package:prlll_24_escuela_programacion/Service/session.dart'; // Asegúrate de importar el archivo adecuado

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompetenciaPage(),
    );
  }
}

class CompetenciaPage extends StatefulWidget {
  @override
  _CompetenciaPageState createState() => _CompetenciaPageState();
}

class _CompetenciaPageState extends State<CompetenciaPage> {
  String selectedFilter = 'Todos'; // Valor inicial para el Dropdown
  List<String> filters = ['Todos', 'Aceptado', 'Pendiente', 'Reprobado'];
  final TextEditingController searchController = TextEditingController();
  final storage = Session(); // Asegúrate de tener una instancia de Session
  String? name;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    Map<String, String?> data = await storage.getSession();
    
    if (data['name'] != null) {
      setState(() {
        name = data['name']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: docenteNavBar(name ?? '...', storage, context), // Utiliza el docenteNavBar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtros y barra de búsqueda
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filtros (DropdownButton)
                DropdownButton<String>(
                  value: selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                    });
                  },
                  items: filters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // Barra de búsqueda
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Nombres, Apellidos o Correos',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción de búsqueda
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8E244D), // Color personalizado
                  ),
                  child: Text(
                    'Buscar',
                    style: TextStyle(color: Colors.white), // Letra en blanco
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Tabla de estudiantes (esto es un placeholder simple)
            Expanded(
              child: Container(
                color: Colors.pink[50],
                child: ListView(
                  children: [
                    // Primera fila de la tabla
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.pink[100],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nombre'),
                          Text('Apellido'),
                          Text('Correo'),
                          Text('Estado'),
                        ],
                      ),
                    ),
                    // Ejemplo de filas de estudiantes
                    studentRow('Diego Adrian', 'Ricaldez', 'jan123@', 'Evaluar'),
                    studentRow('Alvaro', 'Perez Perez', 'abc213321@', 'Aceptado'),
                    studentRow('Nose', 'Pari Choque', 'afasdd1231@', 'Reprobado'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para representar una fila de la tabla de estudiantes
  Widget studentRow(String nombre, String apellido, String correo, String estado) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.pink[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nombre),
          Text(apellido),
          Text(correo),
          estado == 'Evaluar'
              ? ElevatedButton(
                  onPressed: () {
                    // Acción para evaluar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Evaluar',
                    style: TextStyle(color: Colors.white), // Letra en blanco
                  ),
                )
              : Text(estado),
        ],
      ),
    );
  }
}
