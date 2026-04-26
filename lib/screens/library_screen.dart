import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'book_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Book> _librosFiltrados = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarLibros();
  }

  void _cargarLibros() {
    setState(() {
      _librosFiltrados = BookService.getBooks();
    });
  }

  void _filtrarLibros(String query) {
    setState(() {
      if (query.isEmpty) {
        _librosFiltrados = BookService.getBooks();
      } else {
        _librosFiltrados = BookService.getBooks().where((libro) {
          return libro.titulo.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  int get _librosLeidos => BookService.getBooks().length;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5F0E6), Color(0xFFE8DCC8)],
        ),
      ),
      child: Column(
        children: [
          // Header con contador y búsqueda
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5D4037).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contador de libros
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mi Biblioteca',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D4037),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF558B2F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            '$_librosLeidos ${_librosLeidos == 1 ? 'libro' : 'libros'}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Barra de búsqueda
                TextField(
                  controller: _searchController,
                  onChanged: _filtrarLibros,
                  decoration: InputDecoration(
                    hintText: 'Buscar por título del libro...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF8D6E63)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Color(0xFF8D6E63)),
                            onPressed: () {
                              _searchController.clear();
                              _filtrarLibros('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF558B2F), width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Lista de libros
          Expanded(
            child: _librosFiltrados.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchController.text.isEmpty
                              ? Icons.library_books
                              : Icons.search_off,
                          size: 80,
                          color: Color(0xFF8D6E63),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _searchController.text.isEmpty
                              ? 'Tu biblioteca está vacía'
                              : 'No se encontraron resultados',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D4037),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_searchController.text.isEmpty)
                          const Text(
                            'Agrega tu primer libro desde la pestaña "Agregar"',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8D6E63),
                            ),
                          ),
                        if (_searchController.text.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                              _filtrarLibros('');
                            },
                            child: const Text('Limpiar búsqueda'),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _librosFiltrados.length,
                    itemBuilder: (context, index) {
                      final libro = _librosFiltrados[index];
                      return _buildBookCard(libro);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Book libro) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: libro),
          ),
        );
        // Recargar la lista al volver (por si se eliminó algún libro)
        _cargarLibros();
        _filtrarLibros(_searchController.text);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Portada del libro
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 100,
                height: 140,
                child: libro.imagenUrl != null && libro.imagenUrl!.isNotEmpty
                    ? Image.network(
                        libro.imagenUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE8DCC8),
                            child: const Icon(
                              Icons.book,
                              size: 40,
                              color: Color(0xFF8D6E63),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: const Color(0xFFE8DCC8),
                        child: const Icon(
                          Icons.book,
                          size: 40,
                          color: Color(0xFF8D6E63),
                        ),
                      ),
              ),
            ),
            // Información del libro
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      libro.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D4037),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Autor
                    Text(
                      libro.autor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Género
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F0E6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        libro.generoLiterario,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Fila de estrellas y páginas
                    Row(
                      children: [
                        // Estrellas
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < libro.calificacion.floor()
                                  ? Icons.star
                                  : (starIndex < libro.calificacion
                                      ? Icons.star_half
                                      : Icons.star_border),
                              size: 14,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const SizedBox(width: 12),
                        // Páginas
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8DCC8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.menu_book, size: 12, color: Color(0xFF8D6E63)),
                              const SizedBox(width: 4),
                              Text(
                                '${libro.paginas}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF5D4037),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Flecha indicadora
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.chevron_right,
                color: Color(0xFFD7C4A1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}