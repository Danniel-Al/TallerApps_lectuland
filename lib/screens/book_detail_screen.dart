import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar libro'),
        content: Text('¿Seguro que quieres eliminar "${book.titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              BookService.deleteBook(book.id);
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Libro eliminado'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _editarLibro(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookScreen(book: book),
      ),
    );
    if (result == true) {
      Navigator.pop(context, true);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: const Color(0xFF5D4037),
        centerTitle: true,
        actions: [
          // Botón editar
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => _editarLibro(context),
          ),
          // Botón eliminar
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF5F0E6), Color(0xFFE8DCC8)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Estado de lectura
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: book.estadoLectura.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(book.estadoLectura.icon, size: 16, color: book.estadoLectura.color),
                    const SizedBox(width: 6),
                    Text(
                      book.estadoLectura.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: book.estadoLectura.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8DCC8),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: book.imagenUrl != null && book.imagenUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              book.imagenUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.book,
                                  size: 60,
                                  color: Color(0xFF8D6E63),
                                );
                              },
                            ),
                          )
                        : const Icon(
                            Icons.book,
                            size: 60,
                            color: Color(0xFF8D6E63),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.titulo,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D4037),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.autor,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF8D6E63),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < book.calificacion.floor()
                                  ? Icons.star
                                  : (index < book.calificacion
                                      ? Icons.star_half
                                      : Icons.star_border),
                              size: 20,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8DCC8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.numbers, size: 14, color: Color(0xFF5D4037)),
                              const SizedBox(width: 4),
                              Text(
                                '${book.paginas} páginas',
                                style: const TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8DCC8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.language, size: 14, color: Color(0xFF5D4037)),
                              const SizedBox(width: 4),
                              Text(
                                book.idioma,
                                style: const TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Color(0xFFD7C4A1)),
              const SizedBox(height: 16),
              const Text(
                'Datos de Lectura',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('Inicio de lectura', _formatDate(book.fechaInicio)),
              _buildInfoRow('Fin de lectura', _formatDate(book.fechaFin)),
              _buildInfoRow('Género', book.generoLiterario),
              _buildInfoRow('Tipo de serie', book.tipoSerie.toString()),
              _buildInfoRow('Tipo de libro', book.tipo.toString()),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFD7C4A1)),
              const SizedBox(height: 16),
              const Text(
                'Review',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    book.review.resena.isEmpty ? 'Sin reseña escrita' : book.review.resena,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFD7C4A1)),
              const SizedBox(height: 16),
              if (book.review.personajesFavoritos.isNotEmpty) ...[
                const Text(
                  'Personajes Favoritos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: book.review.personajesFavoritos.map((p) {
                    return Chip(
                      label: Text(p),
                      avatar: const Icon(Icons.favorite, size: 16, color: Colors.red),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
              if (book.review.personajesOdiados.isNotEmpty) ...[
                const Text(
                  'Personajes Odiados',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: book.review.personajesOdiados.map((p) {
                    return Chip(
                      label: Text(p),
                      avatar: const Icon(Icons.thumb_down, size: 16, color: Colors.grey),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
              const Divider(color: Color(0xFFD7C4A1)),
              const SizedBox(height: 16),
              const Text(
                'Calificaciones Emocionales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 8),
              _buildEmotionRating('Amor', book.review.amor),
              _buildEmotionRating('Gracioso', book.review.gracioso),
              _buildEmotionRating('Enojo', book.review.enojo),
              _buildEmotionRating('Tristeza', book.review.tristeza),
              _buildEmotionRating('Fantasía', book.review.fantasia),
              _buildEmotionRating('Reflexión', book.review.reflexion),
              _buildEmotionRating('Spicy', book.review.spicy),
              _buildEmotionRating('Trama', book.review.trama),
              _buildEmotionRating('Asesinato', book.review.asesinato),
              _buildEmotionRating('Final', book.review.finalLibro),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFD7C4A1)),
              const SizedBox(height: 16),
              if (book.review.frasesFavoritas.isNotEmpty) ...[
                const Text(
                  'Frases Favoritas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 8),
                ...book.review.frasesFavoritas.map((frase) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.format_quote, color: Color(0xFF558B2F)),
                    title: Text(frase),
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF8D6E63),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Color(0xFF5D4037)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionRating(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF8D6E63)),
            ),
          ),
          Expanded(
            child: Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < value.floor()
                      ? Icons.star
                      : (index < value ? Icons.star_half : Icons.star_border),
                  size: 18,
                  color: Colors.amber,
                );
              }),
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(color: Color(0xFF5D4037), fontSize: 12),
          ),
        ],
      ),
    );
  }
}