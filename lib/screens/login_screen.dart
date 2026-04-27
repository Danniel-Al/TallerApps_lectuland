//Bloque de importaicones
import 'package:flutter/material.dart'; //Material de diseño de la pestaña
import '../services/auth_service.dart'; //Servición para validar credenciales
import 'register_screen.dart'; //Pantalla de registro para navegar allí
import 'home_screen.dart'; //Pantalla principal tras ingreso exitoso

class LoginScreen extends StatefulWidget { //Se crea pantalla llamada loginscreen
  final AuthService authService; //La pantalla guardará un servicio de autenticación 

  const LoginScreen({super.key, required this.authService}); //

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> { //
  final _formKey = GlobalKey<FormState>(); // Identifica el formulario para validarlo (si todos los campos son correctos)
  final _usernameController = TextEditingController(); //Controla el campo de texto del usuario
  final _passwordController = TextEditingController(); //Controla el campo de texto de contraseña

  void _login() {
    if (_formKey.currentState!.validate()) { //Valida todos los campos
      final success = widget.authService.login( //Llama al servicio de autenticación para verificar usuario y contraseña
        _usernameController.text.trim(), //Elimina espacios en blanco al inicio y al final
        _passwordController.text, 
      );

      if (success) { 
        Navigator.pushReplacement( //Si las credenciales son correctas se dirige a la pantalla de inicio
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar( //De no cumplirse la condicional aparece mensaje de error en la parte inferior
          const SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  void dispose() { //Se limpia la memoria cuando la pantalla ya no se necesita
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override //Montar la interfaz visual de la pantalla de login
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  //Barra superior con título
        title: const Text('Iniciar Sesión'),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: Container( //Contenido principal de pantalla, widget que decora interior
        decoration: const BoxDecoration(  //Fondo
          gradient: LinearGradient( //Degradado
            begin: Alignment.topLeft, //Inicio del degradado
            end: Alignment.bottomRight, //Fin del degradado
            colors: [Color(0xFFF5F0E6), Color(0xFFE8DCC8)],
          ),
        ),
        child: Padding( //Espacio alrededor del contenido
          padding: const EdgeInsets.all(24.0),
          child: Form( //Agrupa campos
            key: _formKey,
            child: Column( //Columnas una abajo de la otra
              mainAxisAlignment: MainAxisAlignment.center, //Centra el contenido verticalmente
              children: [
                const Icon(
                  Icons.library_books,
                  size: 80,
                  color: Color(0xFF5D4037),
                ),
                const SizedBox(height: 30),
                const Text(
                  'LECTULAND',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController, //Crea campo de texto que valide que no esté vacío
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, //Lo que se escribe aparece como astericos
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login, //Ejecuta el método de _login al hacer clic
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), //El botón ocupa todo el ancho disponible
                  ),
                  child: const Text('INICIAR SESIÓN'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push( //Agrega nueva pantalla encima de la actual
                      context,
                      MaterialPageRoute( //Transición a nueva pantalla
                        builder: (context) => RegisterScreen(
                          authService: widget.authService,
                        ),
                      ),
                    );
                  },
                  child: const Text('¿No tienes cuenta? Regístrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}