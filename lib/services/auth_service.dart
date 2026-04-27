import '../models/user.dart'; //Se orienta la carpeta primero se dirige a lib/ para luego a models/usert.dart para crear al usuario

class AuthService { //Define el servicio que contiene la lógica de autentificación
  final List<User> _users = []; //Lista privada que almacena usuarios registrados, es privada

  bool register(String username, String password) {
    if (username.isEmpty || password.isEmpty) {  //Verifica si algún campo está vacío
      return false; //De estar vacío, falla el registro
    }
    if (password.length < 4) { //Contraseña con al menos 4 caracteres
      return false; //Si es muy corta falla
    }
    if (_users.any((user) => user.username == username)) { //Busca si xiste un usario con ese nombre
      return false; //Si existe, falla
    }
    _users.add(User(username: username, password: password)); //Crea un nuevo usuario
    return true; //devuelve verdadero indicando éxito
  }

  bool login(String username, String password) { //Si los datos deinicio de sesión son correctos devuelve true
    return _users.any( //Recorre toda la lista de usuarios para encontrar coincidencias
      (user) => user.username == username && user.password == password,
    );
  }

  bool get hasUsers => _users.isNotEmpty; //Identiifcar si hay algún usuario registrado sin acceder a la lista privada
}

// Al cerrar la app, se pierden los usarios ya que se estos se guardan en la meomria RAM del equipo