import '../models/user.dart';

class AuthService {
  // "Base de datos" en memoria (se pierde al cerrar la app)
  final List<User> _users = [];

  // Registrar nuevo usuario
  bool register(String username, String password) {
    // Validaciones
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    if (password.length < 4) {
      return false;
    }
    // Verificar si ya existe
    if (_users.any((user) => user.username == username)) {
      return false;
    }
    // Guardar usuario
    _users.add(User(username: username, password: password));
    return true;
  }

  // Iniciar sesión
  bool login(String username, String password) {
    return _users.any(
      (user) => user.username == username && user.password == password,
    );
  }

  // Verificar si hay usuarios registrados
  bool get hasUsers => _users.isNotEmpty;
}