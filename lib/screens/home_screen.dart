import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'add_book_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Biblioteca'),
        backgroundColor: const Color(0xFF5D4037),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    authService: AuthService(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF5F0E6), Color(0xFFE8DCC8)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_stories,
                size: 80,
                color: Color(0xFF5D4037),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Bienvenido a Lectuland!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Comienza a registrar tus lecturas',
                style: TextStyle(fontSize: 16, color: Color(0xFF8D6E63)),
              ),
              const SizedBox(height: 40),
              // Botón para agregar libro
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddBookScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('AGREGAR LIBRO'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF558B2F),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}