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
    5.	El frontend desarrollado en Flutter envía solicitudes HTTP a la API ASP.NET utilizando métodos como GET, POST, PUT y DELETE.
    Las respuestas de la API, en formato JSON, son procesadas por el frontend para actualizar la interfaz de usuario de manera dinámica.
    6.	Operaciones en la Base de Datos: La API establece una conexión con MySQL Server para realizar operaciones de lectura, escritura, actualización y eliminación.Las operaciones se realizan utilizando consultas SQL optimizadas a través de Entity Framework Core, asegurando integridad y eficiencia en el acceso a los datos.

6.	Base de datos
    a.	Diagrama completo y actual
        (Diagrama en el word)

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
    Requerimientos de Hardware (mínimo): (cliente)
    •	Procesador: Intel Core i3 o equivalente.
    •	Memoria RAM: 4 GB.
    •	Espacio en Disco: 2 GB disponibles.
    •	Resolución de Pantalla: 1366 x 768 o superior.
    •	Conexión a Internet: 5 Mbps de velocidad mínima.

    Requerimientos de Software: (cliente)
    •	Sistema Operativo:
        o	Windows 10 o superior.
        o	Android 9 (Pie) o superior.
    •	Navegadores Compatibles:
        o	Cualquier navegador disponible (versión más reciente)

    Requerimientos de Hardware (server/ hosting/BD)
    •	Procesador: Gama media (Intel i3)
    •	Memoria RAM: 8 GB (mínimo); 16 GB (recomendado para alta concurrencia).
    •	Espacio en Disco: 50 GB SSD (mínimo) para almacenamiento de datos y logs.
    •	Conectividad de Red: 5 Mbps de velocidad mínima.

    Requerimientos de Software (server/ hosting/BD)
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
    El proyecto está contenido en contenedores de docker, para lo cual se tendrá que importar las imágenes de la base de datos, api y la web de flutter o sino crearlas con los dockerfile de cada componente y hacerlas funcionar. 

    Si es necesario, en el proyecto de flutter, deberemos modificar las url o direcciones que se conectan con la api, dentro del archivo /lib/Service/ServicioBase.dart.

    También cambiar la cadena de conexión en la api para establecer la conexión con la base de datos., dentro del archivo /appsettings.json.

    Otra cosa importante seria configurar los puertos de los contenedores y como se conectan. Dentro de cada componente en su respectivo dockerfile.

10.	GIT: 
    •	Versión final entregada del proyecto.
    •	Entrega compilados ejecutables
    git la pagina web
    git de la api

11.	Dockerizado Del Sitio WEB, de la Base de Datos

    Pasos para crear el contenedor de la Base de datos en docker:
    1.	Descargar el proyecto y dirigirse a la carpeta de la base de datos
    2.	Una vez obtenido el archivo “escuela-mysql.tar” abrimos una consola en la ubicación del archivo con el servicio de docker corriendo
    3.	En esta consola ejecutaremos el siguiente comando: “docker load -i escuela-mysql.tar” para asi tener importada la nueva imagen.
    4.	Una vez realizado esto ejecutaremos el siguiente comando: “docker run --name escuelaProgramacionDocker –e MYSQL_ROOT_PASSWORD=1234567 -p 3306:3306 -d mysql:8.0”
    5.	Hecho esto ya se nos habrá creado la base de datos en docker.


    Pasos para crear el contenedor de la aplicación de web de flutter: 
    1.	Descargar el proyecto del GitHub
    2.	Una vez obtenido el archivo “escuela_programacion.tar” entramos a la consola en la ubicación del archivo
    3.	Una vez abierto esto ejecutaremos el siguiente comando: “docker load -i escuela_programacion.tar” para cargar el contenedor.
    4.	Luego ejecutaremos el siguiente comando: “docker run -i -p 8080:9000 -td escuela_programacion” para ejecutar el contenedor.
    5.	Hecho esto ya se nos habrá creado la aplicación web en Docker.


12.	Personalización y configuración: Información sobre cómo personalizar y configurar el software según las necesidades del usuario, incluyendo opciones de configuración, parámetros y variables.

    Para cambiar la url de la api se puede hacerlo cambiándolo en el archivo /lib/Service/ServicioBase.dart. de la aplicación web.

    Para personalizar los colores de la aplicación, hay que cambiar valor de los colores de os componentes de las páginas que se quieran cambiar el color

13.	Seguridad: 

La seguridad del sistema "Escuela Programación" es de suma importancia para proteger los datos sensibles de estudiantes, docentes y administradores. A continuación, se detallan las consideraciones y recomendaciones de seguridad para garantizar la integridad y confidencialidad de la información: 

    Permisos de Acceso
    Roles y Permisos:
        o	Establecer roles claramente definidos (Administrador, Docente, Estudiante) con permisos específicos.
        o	Restringir el acceso a funcionalidades sensibles únicamente a los roles autorizados.
    Autenticación
    1.	Autenticación Fuerte:
        o	Usar contraseñas seguras y políticas de cambio regular de contraseñas.
14.	Depuración y solución de problemas: Instrucciones sobre cómo identificar y solucionar problemas comunes, mensajes de error y posibles conflictos con otros sistemas o componentes.

    Los errores comunes se mostrarán como un message box para el usuario o sino como mensajes de consola

15.	Referencias y recursos adicionales: Enlaces o referencias a otros recursos útiles, como documentación técnica relacionada, tutoriales o foros de soporte.

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

