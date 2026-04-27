import '../models/book.dart'; //Se dirige lib/ para entrar posteriormente a modelrs/book.dart y trabajar con los libros registrados

class BookService {
  static final List<Book> _libros = []; //Lista que solo puede contener objetos tipo Book

  static void addBook(Book libro) { //Guarda un nuevo libro en la base de datos
    _libros.add(libro);
  }

  static void updateBook(Book libroActualizado) {
    final index = _libros.indexWhere((book) => book.id == libroActualizado.id); //Busca la posición del libro que tenga el mismo id que el libro actualizado y compara con el que se pretende actualziar
     //Guarda posición encontrada
    if (index != -1) { //Cuestiona si se encontró el libro
      _libros[index] = libroActualizado; //Reemplaza el libro vieo por el nuevo en esa posición
    }
  }

  static List<Book> getBooks() { //Obtener libros sin permitir modificaciones directas a la lista interna
    //Se de vuelve una copia de la lista interna
    //Se crea una nueva lista con los mismos elementos
    return List.from(_libros);
  }

  static Book? getBookById(String id) { //Puede devolver un un libro o no en función de si lo encuentra
    try { //Intenta ejectuar el código interno
      return _libros.firstWhere((book) => book.id == id); //Busca el primer libroque cumpla la condición
      //Compara el id de cada libro con el id buscado
      //De no encontrar el libro devuelve null
    } catch (e) {
      return null;
    }
  }

  static void deleteBook(String id) {
    _libros.removeWhere((book) => book.id == id); //Elimina de la lista todos los elementos que cumplan la condición
    //Se elimina el libro cuyo id coincida
  }

  static int get count => _libros.length; // Crea una propiedad calculada para devolver la cantidad d elibros en la lista
}