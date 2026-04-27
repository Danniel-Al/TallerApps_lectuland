class User { //Plantilla para crear al usuario
  final String username; //Solo se asigna una vez el onmbre del usuario
  final String password; //Solo es asigna una vez la contraseña para autentificar al usuario

  User({ //Obligatorio proporcionar nombre y contraseña para ingresar
    required this.username,
    required this.password,
  });
}