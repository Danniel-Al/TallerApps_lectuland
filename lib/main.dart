//Bloque de Importaciones para usar en código
import 'package:flutter/material.dart'; //Material visual de google, colores, texto,etc.
import 'screens/login_screen.dart'; // Pantalla de inicio de sesión
import 'services/auth_service.dart'; //Pantalla de registro y validación de contraseñas

//Entrada de la app
void main() {
  runApp(const LectulandApp()); // Función para arrancar la app
}

//Declaración de clase principal
class LectulandApp extends StatelessWidget { // Se refiere a que la app no cambia de estado por loq ue no necesita actualizarse
  const LectulandApp({super.key}); // Identificar la app con un identificador

  @override
  Widget build(BuildContext context) { //Construcción de la interfaz, temas, rutas, pantalla principal
    return MaterialApp( // Widget para diseñar la app (nagefación, temas, título)
      title: 'Lectuland',
      theme: ThemeData( //Agrupa estilos visuales de la app
        primarySwatch: Colors.brown, //Color principal
        scaffoldBackgroundColor: const Color(0xFFF5F0E6), //Color de fondo
        appBarTheme: const AppBarTheme( //Estilo de la barra superior 
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white, //Color de texto e íconos en barra
          elevation: 0, // Eliminar la sombra
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( //Estilo de todos los botones
          style: ElevatedButton.styleFrom( //Método a partir de propiedades simples
            backgroundColor: const Color(0xFF558B2F), 
            foregroundColor: Colors.white,
            minimumSize: const Size(200, 50), // Definiicón de todos los botones
            shape: RoundedRectangleBorder( //Forma redondeada al botón
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: LoginScreen(authService: AuthService()), // Define qué pantalla se muestra primero al abrir app
      debugShowCheckedModeBanner: false, //Ocultar el letreto debug
    );
  }
}