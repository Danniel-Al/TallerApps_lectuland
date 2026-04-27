//Importa bibliotecas
import 'package:flutter/material.dart'; //Diseño visual de flutter
import '../services/auth_service.dart'; //Servicio que maneja el servicio de usuario

//Pantalla de registro denuevos usuarios
class RegisterScreen extends StatefulWidget {
  final AuthService authService;   //Recibe servicio de autenticación desde pantalla de login

  const RegisterScreen({super.key, required this.authService});

  //Se crea el objeto que maneja el estado de esta pantalla
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Almacenamiento de valores que cambian 

  final _formKey = GlobalKey<FormState>(); //Clave del formulario para validar todos los campos a la vez
  //Controladores de texto
  final _usernameController = TextEditingController(); 
  final _passwordController = TextEditingController(); 
  final _confirmPasswordController = TextEditingController();

  void _register() {
    //Validar si el formulario esta completo
    if (_formKey.currentState!.validate()) {
      final success = widget.authService.register(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      //Intentar registrar al usuario
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registro exitoso! Ahora inicia sesión'),
          ),
        );
        Navigator.pop(context);
      } else {
        //Se muestra mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario ya existe o contraseña muy corta'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    //Libera cada controlador de texto
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  //Interfaz visual de la pantalla
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF5F0E6), Color(0xFFE8DCC8)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add,
                  size: 80,
                  color: Color(0xFF5D4037),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un nombre de usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa una contraseña';
                    }
                    if (value.length < 4) {
                      return 'La contraseña debe tener al menos 4 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                //Boton principal para registrarse
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('REGISTRARSE'),
                ),
                //Boton secundario para volver a la página de login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}