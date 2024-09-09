import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaEstudiantesPage(),
    );
  }
}

class ListaEstudiantesPage extends StatefulWidget {
  @override
  _ListaEstudiantesPageState createState() => _ListaEstudiantesPageState();
}

class _ListaEstudiantesPageState extends State<ListaEstudiantesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo_univalle.png', height: 50),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Karen Poma", style: TextStyle(fontSize: 16)),
                Text("Univalle", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF8E244D),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Reportes', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Calificaciones', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Escuelas', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Estudiantes', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Docentes', style: TextStyle(color: Colors.white)),
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
          children: [
            SizedBox(height: 30),
            Text(
              'LISTA DE ESTUDIANTES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E244D),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Acción de añadir estudiante
                },
                icon: Icon(Icons.person_add, color: Colors.white),
                label: Text('Añadir'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFE0BFC7), // Fondo rosado para la tabla
                borderRadius: BorderRadius.circular(8),
              ),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Apellido')),
                  DataColumn(label: Text('Correo')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: [
                  _buildDataRow('Diego Adrian', 'Ricaldez', 'jan123@'),
                  _buildDataRow('Alvaro', 'Perez Perez', 'abc213321@'),
                  _buildDataRow('Nose', 'Pari Choque', 'afasdd1231@'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('← Previous', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xFF8E244D),
                  child: Text('1', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                Text('2', style: TextStyle(color: Color(0xFF8E244D))),
                Text(' 3 ... 67 68 ', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 10),
                Text('Next →', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(String nombre, String apellido, String correo) {
    return DataRow(cells: [
      DataCell(Text(nombre)),
      DataCell(Text(apellido)),
      DataCell(Text(correo)),
      DataCell(Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Acción de modificar
            },
            icon: Icon(Icons.sync, color: Colors.white),
            label: Text('Modificar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // Color del botón modificar
              minimumSize: Size(100, 30),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Acción de eliminar
            },
            icon: Icon(Icons.cancel, color: Colors.white),
            label: Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8E244D), // Color del botón eliminar
              minimumSize: Size(100, 30),
            ),
          ),
        ],
      )),
    ]);
  }
}
