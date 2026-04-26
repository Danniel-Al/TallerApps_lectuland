class User {
  final String username;
  final String password;

  User({
    required this.username,
    required this.password,
  });

  // Convertir a mapa (para guardar en base de datos después)
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
