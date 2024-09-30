import 'package:flutter/material.dart';
import 'package:prlll_24_escuela_programacion/Service/CalificarEstudianteService.dart';
import 'package:prlll_24_escuela_programacion/models/EstudianteCalificacion.dart';
import 'package:prlll_24_escuela_programacion/pages/docente/calificar_prueba.dart';


class CompetenciaPage extends StatefulWidget {
  final int idCompetencia;

  CompetenciaPage({required this.idCompetencia}); // Asegúrate de que esto esté definido


  @override
  _CompetenciaPageState createState() => _CompetenciaPageState();
}

class _CompetenciaPageState extends State<CompetenciaPage> {
  String selectedFilter = 'Todos';
  List<String> filters = ['Todos', 'Aceptado', 'Pendiente', 'Reprobado'];
  final TextEditingController searchController = TextEditingController();
  List<Estudiante> estudiantes = [];
  List<Estudiante> filteredEstudiantes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEstudiantes();
  }

  Future<void> fetchEstudiantes() async {
    try {
      final fetchedEstudiantes = await fetchEstudiantesSer(widget.idCompetencia);
      setState(() {
        estudiantes = fetchedEstudiantes;
        filteredEstudiantes = estudiantes;
        isLoading = false;
      });
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterEstudiantes() {
    setState(() {
      String searchText = searchController.text.toLowerCase();
      filteredEstudiantes = estudiantes.where((estudiante) {
        bool matchesSearch = estudiante.nombre.toLowerCase().contains(searchText) ||
                             estudiante.correo.toLowerCase().contains(searchText);
        bool matchesFilter = selectedFilter == 'Todos' ||
                             getEstadoText(estudiante.aprobado) == selectedFilter;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  String getEstadoText(int aprobado) {
    switch (aprobado) {
      case 0: return 'Pendiente';
      case 1: return 'Aceptado';
      case 2: return 'Reprobado';
      default: return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo_univalle.png', height: 50),
            SizedBox(width: 10),
            Text("Lista de Estudiantes en Competencia"),
          ],
        ),
        backgroundColor: Color(0xFF8E244D),
        actions: [
          DropdownButton(
            icon: Icon(Icons.people, color: Colors.white),
            items: [DropdownMenuItem(child: Text('Estudiantes'))],
            onChanged: (value) {},
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para cerrar sesión
            },
            child: Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                      _filterEstudiantes();
                    });
                  },
                  items: filters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        _filterEstudiantes();
                      },
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
                  onPressed: _filterEstudiantes,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8E244D),
                  ),
                  child: Text('Buscar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                color: Colors.pink[50],
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: filteredEstudiantes.length,
                        itemBuilder: (context, index) {
                          final estudiante = filteredEstudiantes[index];
                          return studentRow(estudiante);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget studentRow(Estudiante estudiante) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.pink[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(estudiante.nombre, overflow: TextOverflow.ellipsis)),
          Expanded(child: Text(estudiante.correo, overflow: TextOverflow.ellipsis)),
          estudiante.aprobado == 0
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalificarPrueba(id: estudiante.id, idCompetencia: widget.idCompetencia),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text('Evaluar', style: TextStyle(color: Colors.white)),
                )
              : Text(getEstadoText(estudiante.aprobado)),
        ],
      ),
    );
  }
}
