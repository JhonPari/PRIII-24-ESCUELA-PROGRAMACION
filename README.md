Manual Técnico

1.	Roles / integrantes
Integrantes	Rol
Diego Adrian Ricaldez Aguilar	Team Leader / Dev
Jhon Arnol Pari Siles	Git Master / Dev
Karen Poma Ticlla	DB Architect / Dev

2.	Introducción:
El sistema Escuela Programación está diseñado para gestionar el proceso de evaluación y seguimiento del aprendizaje en una institución educativa enfocada en competencias programáticas. Este sistema tiene como objetivo principal optimizar y automatizar las interacciones entre estudiantes y docentes en relación con la presentación, revisión y aprobación de pruebas asignadas dentro de las competencias académicas.

3.	Descripción del proyecto:
El proyecto Escuela Programación se desarrollará utilizando una combinación de herramientas de software y una arquitectura eficiente para garantizar la funcionalidad integral del sistema. El objetivo principal es crear una página web que permita gestionar el proceso de evaluación de competencias de manera eficiente, tanto para estudiantes como para docentes.

Detalles del Sistema
En el ámbito del software, se emplearán herramientas modernas para la implementación del proyecto, incluyendo:

    •	Visual Studio Code para el desarrollo del sistema principal.
    •	MYSQL Server como base de datos para el almacenamiento seguro y estructurado de toda la información académica.
    •	FLUTTER para el diseño de una interfaz gráfica intuitiva y fácil de usar.
    •	ASP.NET para el desarrollo del API de la web
    •	Docker para la contenedorización del sistema, asegurando portabilidad y escalabilidad.
4.	Listado de los Requisitos Funcionales del Sistema

Requisitos Funcionales para los Estudiantes

    1.	Visualización de Competencias Asignadas: Los estudiantes pueden ver una lista de las competencias asignadas, junto con sus descripciones.
    2.	Gestión de Pruebas: Subir imágenes como pruebas en las competencias asignadas.
    3.	Consultar el estado de la prueba (en revisión, aprobada o reprobada).
    4.	Visualización de Puntos: Consultar sus puntos acumulados por competencia.

Requisitos Funcionales para los Docentes

    1.	Visualización de Competencias:  Consultar todas las competencias disponibles en el sistema.
    2.	Calificación de Estudiantes: Seleccionar una competencia específica para visualizar la lista de estudiantes asociados a esa competencia.
    3.	Aprobar o reprobar las pruebas de los estudiantes.
    4.	Generación de Reportes de Estudiantes: Generar reportes grupales sobre el desempeño de los estudiantes por competencia, incluyendo puntos acumulados y otro reporte por fechas.

Requisitos Funcionales para el Administrador

    1.	Gestión de Estudiantes, Docentes y Escuelas: Crear, editar y eliminar estudiantes, docentes y escuelas desde un panel administrativo.
    2.	Gestión de Usuarios: Registrar Revisar y aprobar o rechazar las solicitudes de registro de nuevos usuarios en la página.
    3.	Reportes Generales: Generar reportes grupales sobre el desempeño de los estudiantes por competencia, incluyendo puntos acumulados, reporte por fechas, reporté por escuelas
    4.	Reportes Exportables: Permitir la exportación de reportes en formatos estándar, como PDF o Excel, para facilitar su distribución.

5.	Arquitectura del software: 

La arquitectura del sistema Escuela Programación está diseñada para garantizar una separación clara de responsabilidades y permitir la escalabilidad, el mantenimiento y la interacción eficiente entre sus componentes. A continuación, se detalla cómo está estructurado el sistema, considerando los componentes principales:

Componentes Principales

    1.	Base de Datos: MySQL Server Utilizamos MySQL Server como base de datos para almacenar y gestionar los datos del sistema.
    La base de datos está estructurada bajo un modelo relacional, definiendo tablas con relaciones bien establecidas.
    Contiene información clave como estudiantes, docentes, competencias y pruebas de los estudiantes
    2.	API Backend: ASP.NET Core
    Desarrollamos una API utilizando ASP.NET para manejar la comunicación entre el frontend y la base de datos.
    La API define controladores y rutas para procesar las solicitudes del frontend, como gestionar competencias, subir pruebas y generar reportes.

    3.	Interfaz de Usuario: Flutter que permite desarrollar aplicaciones web responsivas y adaptables a diferentes dispositivos.
    4.	Flutter proporciona componentes reutilizables y un sistema de gestión eficiente del estado, lo que facilita la navegación entre vistas, como la visualización de competencias, calificación de pruebas y gestión administrativa.
    Interacciones entre Componentes	

    1.	El frontend desarrollado en Flutter envía solicitudes HTTP a la API ASP.NET utilizando métodos como GET, POST, PUT y DELETE.
    Las respuestas de la API, en formato JSON, son procesadas por el frontend para actualizar la interfaz de usuario de manera dinámica.
    2.	Operaciones en la Base de Datos: La API establece una conexión con MySQL Server para realizar operaciones de lectura, escritura, actualización y eliminación.Las operaciones se realizan utilizando consultas SQL optimizadas a través de Entity Framework Core, asegurando integridad y eficiencia en el acceso a los datos.

6.	Base de datos
    a.	Diagrama completo y actual

    b.	En el GIT una carpeta con la base de datos con script de generación e inserción de datos de ejemplo utilizados

    c.	Script simple (copiado y pegado en este documento)

7.	Listado de Roles más sus credenciales de todos los Admin / Users del sistema
    Administrador
    Usuario: docenteuni45@gmail.com
    Contraseña: BUteKZzs
    
    docente
    Usuario: correo2581628352816@gmail.com
    Contraseña: V^qShJeJ
    
    Estudiante
    Usuario: udianteest42@gmail.com
    Contraseña: RpSGPTfr

8.	Requisitos del sistema:
    •	Requerimientos de Hardware (mínimo): (cliente)
        •	Procesador: Intel Core i3 o equivalente.
        •	Memoria RAM: 4 GB.
        •	Espacio en Disco: 2 GB disponibles.
        •	Resolución de Pantalla: 1366 x 768 o superior.
        •	Conexión a Internet: 5 Mbps de velocidad mínima.

    •	Requerimientos de Software: (cliente)
        •	Sistema Operativo:
            o	Windows 10 o superior.
            o	Android 9 (Pie) o superior.
        •	Navegadores Compatibles:
            o	Cualquier navegador disponible (versión más reciente)

    •	Requerimientos de Hardware (server/ hosting/BD)
        •	Procesador: Gama media (Intel i3)
        •	Memoria RAM: 8 GB (mínimo); 16 GB (recomendado para alta concurrencia).
        •	Espacio en Disco: 50 GB SSD (mínimo) para almacenamiento de datos y logs.
        •	Conectividad de Red: 5 Mbps de velocidad mínima.

    •	Requerimientos de Software (server/ hosting/BD)
        •	Sistema Operativo:
            o	Windows Server 2019 o superior (para API).
            o	Linux (Ubuntu 20.04 LTS o CentOS 8 para hosting de la base de datos).
        •	Frameworks y Herramientas:
            o	ASP.NET. Framework o superior (para la API).
            o	MySQL Server 8.0 o superior (base de datos).
        •	Certificados y Seguridad:
            o	Certificado SSL/TLS para HTTPS.
            o	Firewalls y reglas de acceso configuradas para restringir conexiones no autorizadas.
        •	Dependencias Adicionales:
            o	Docker


9.	Instalación y configuración:
Para seguir con el desarrollo hay que hacer lo siguiente
    Para utilizar la página web:
        1. Instalar Flutter
            •	Descarga Flutter: Ve a la página oficial de Flutter y descarga el SDK para tu sistema operativo. La version utilizada es la 3.24.1
            •	Extrae el SDK: Descomprime el archivo descargado en una ubicación deseada (por ejemplo, C:\flutter en Windows).
            •	Agrega Flutter al PATH: Añade la ruta del directorio flutter/bin a la variable de entorno PATH para usar Flutter desde la terminal.
        2. Instalar visual studio code
        3. Instalar extenciones de flutter
            •	Dart
            •	Flutter
        4. recompilar el proyecto para cargar dependencias
            •	Poner en la consola del proyecto “flutter pub get”

    Para utilizar la api:
        1. Instalar visual studio con desarrollo web asp
    Para utilizar la base de datos:
        1. Instalar mySQL

10.	GIT: 
    •	Versión final entregada del proyecto.
    •	Entrega compilados ejecutables
    git la pagina web https://github.com/JhonPari/PRIII-24-ESCUELA-PROGRAMACION
    git de la api https://github.com/JhonPari/PRIII-24-ESCUELA-PROGRAMACION-API

11.	Dockerizado

Pasos para crear el contenedor de la Base de datos, la Api y el sitio Web con docker compose:
    1.	Descargar el proyecto web y el proyecto del api
    2.	Ordernar los archivos de la siguiente manera dentro de una nueva carpeta:
    . 
    ├── base/ 
    ├── PRIII-24-ESCUELA-PROGRAMACION/ 
    ├── PRIII-24-ESCUELA-PROGRAMACION-API/ 
    ├── docker-compose.debug.yml 
    └── docker-compose.yml
    La carpeta base esta dentro de “PRIII-24-ESCUELA-PROGRAMACION" y los archivos docker-compose estan dentro de la carpeta “base”
    3.	Una vez ordenados los archivos, abrimos una consola de comandos en la carpeta raiz
    4.	En esta consola ejecutaremos el siguiente comando: “docker-compose up --build”.
    5.	Hecho esto ya se nos habrán creado y estaran funcionando los docker de la base de datos, la api y la pagina web. Todos conectados y funcionando.


12.	Personalización y configuración: 

•	Para cambiar la url que la página web usa para conectarse al api hay que cambiar el siguiente archivo del proyecto web:  /lib/Service/ServicioBase.dart.
•	Para cambiar el puerto que usa la pagina web en el docker hay que cambiar los siguientes archivos en: 
    -	En el dockerfile de la página web EXPOSE 9000 hay que cambiar el 9000 por el 	puerto deseado.
    -	Tambien en el docker compose dentro de flutter_web: ports: 9000:9000 se cambia por 	el puerto utilizado en el dockerfile.
•	Para cambiar cualquier atributo de la como el usuario la contraseña, puerto, nombre de la base y puertos se cambian todos en el docker-compose en la seccion: services: db:
•	Para cambiar la conexion de la api a la base de datos hay que cambiar el archivo appsettings.json del proyecto de la api en la sección "ConnectionStrings" y hacer los cambios deseados a la coneccion.

•	Para personalizar los colores de la página web, hay que dirigirse al componente que se quiera cambiar de color y cambiarlo ya que casi todos los componentes en flutter tienen un atributo color para personalizarlo

13.	Seguridad: 

La seguridad del sistema "Escuela Programación" es de suma importancia para proteger los datos sensibles de estudiantes, docentes y administradores. A continuación, se detallan las consideraciones y recomendaciones de seguridad para garantizar la integridad y confidencialidad de la información: 

Permisos de Acceso
Roles y Permisos:
    o	Establecer roles claramente definidos (Administrador, Docente, Estudiante) con permisos específicos.
    o	Restringir el acceso a funcionalidades sensibles únicamente a los roles autorizados.
Autenticación
1.	Autenticación Fuerte:
    o	Usar contraseñas seguras y políticas de cambio regular de contraseñas.

14.	Depuración y solución de problemas:

Los errores comunes se mostrarán como un message box para el usuario o sino como mensajes de consola

15.	Referencias y recursos adicionales:

https://medium.com/@reyes160/flutter-web-and-docker-container-fddbd04203fc
https://flutter.dev
https://pub.dev
https://chatgpt.com


16.	Herramientas de Implementación:
    •	Lenguajes de programación: 
        Para la página Web se usó el lenguaje de programación de Dart
        Para el api se usó asp.net framework que usa el lenguaje de C#
    •	Frameworks:
        Se uso el framework de Flutter con Dart para el manejo de la interfaz grafica