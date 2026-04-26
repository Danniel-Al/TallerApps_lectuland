import '../models/user.dart';

class AuthService {
  final List<User> _users = [];

  bool register(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    if (password.length < 4) {
      return false;
    }
    if (_users.any((user) => user.username == username)) {
      return false;
    }
    _users.add(User(username: username, password: password));
    return true;
  }

  bool login(String username, String password) {
    return _users.any(
      (user) => user.username == username && user.password == password,
    );
  }

  bool get hasUsers => _users.isNotEmpty;
}