import 'package:flutter/material.dart';

AppBar adminNavBar(String nombre) {
  // Definir un estilo de texto común
  TextStyle commonTextStyle =
      const TextStyle(fontSize: 16, color: Colors.black);

  return AppBar(
    backgroundColor: const Color(0xFF8B2D56),
    title: Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo_univalle.png'),
          radius: 20,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: commonTextStyle.copyWith(color: Colors.white38),
            ),
            const Text(
              'Estudiante Univalle',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Manejar la acción seleccionada
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'ver_puntos',
                child: Text('Ver Puntos', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'ver_fecha',
                child: Text('Ver Fecha', style: commonTextStyle),
              ),
            ];
          },
          child: Text(
            'Reportes',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: Text(
            'Calificaciones',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: Text(
            'Escuelas',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Manejar la acción seleccionada
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'lista_Estudiantes',
                child: Text('Lista Estudiantes', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'agregar_estudiante',
                child: Text('Agregar Estudiante', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'solicitud',
                child: Text('Ver Solicitudes', style: commonTextStyle),
              ),
            ];
          },
          child: Text(
            'Estudiantes',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<String>(
          onSelected: (value) {
            
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'lista_Docentes',
                child: Text('Lista Docentes', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'agregar_Docentes',
                child: Text('Agregar Docentes', style: commonTextStyle),
              ),
              PopupMenuItem<String>(
                value: 'solicitud',
                child: Text('Ver Solicitudes', style: commonTextStyle),
              ),
            ];
          },
          child: Text(
            'Docentes',
            style: commonTextStyle,
          ),
        ),
        const SizedBox(width: 25),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), 
            ),
          ),
          child: const Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
