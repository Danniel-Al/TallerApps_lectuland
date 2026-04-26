import 'package:flutter/material.dart';

void main() {
  runApp(const LectulandApp());
}

class LectulandApp extends StatelessWidget {
  const LectulandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lectuland',
      theme: ThemeData(
        // Color principal (botones, barras, etc.)
        primarySwatch: Colors.brown,
        // Color de fondo general
        scaffoldBackgroundColor: const Color(0xFFF5F0E6),
        // Estilo de la AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // Estilo de botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF558B2F),
            foregroundColor: Colors.white,
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F0E6), // Beige claro (arriba)
              Color(0xFFE8DCC8), // Beige medio (centro)
              Color(0xFFD7C4A1), // Marfil suave (abajo)
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 📚 Icono decorativo de biblioteca
                  const Icon(
                    Icons.local_library,
                    size: 80,
                    color: Color(0xFF5D4037),
                  ),
                  const SizedBox(height: 20),
                  // Título principal
                  const Text(
                    'LECTULAND',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Color(0x40FFC107),
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Línea decorativa
                  Container(
                    width: 80,
                    height: 3,
                    color: const Color(0xFFFFC107),
                  ),
                  const SizedBox(height: 20),
                  // Lema principal
                  const Text(
                    '"Una biblioteca al alcance de tu mano"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6D4C41),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Subtítulo
                  const Text(
                    'Reseña · Califica · Comparte',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8D6E63),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Botón de entrar (verde biblioteca)
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('📖 Bienvenido a Lectuland. Próximamente: tu biblioteca personal'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Color(0xFF5D4037),
                        ),
                      );
                    },
                    child: const Text(
                      'ENTRAR A LA BIBLIOTECA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Decoración: libro abierto con emoji
                  const Text(
                    '📖✨📚',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFFFC107),
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