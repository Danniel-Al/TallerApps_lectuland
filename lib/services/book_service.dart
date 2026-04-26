import '../models/book.dart';

class BookService {
  static final List<Book> _libros = [];

  static void addBook(Book libro) {
    _libros.add(libro);
  }

  static List<Book> getBooks() {
    return List.from(_libros);
  }

  static Book? getBookById(String id) {
    try {
      return _libros.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  static void deleteBook(String id) {
    _libros.removeWhere((book) => book.id == id);
  }

  static int get count => _libros.length;
}