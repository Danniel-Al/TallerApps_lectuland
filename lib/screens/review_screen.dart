import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/star_rating.dart';

class ReviewScreen extends StatefulWidget {
  final Function(Review) onReviewComplete;

  const ReviewScreen({super.key, required this.onReviewComplete});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _resenaController = TextEditingController();

  final List<String> _personajesFavoritos = [];
  final List<String> _personajesOdiados = [];
  final TextEditingController _nuevoPersonajeFav = TextEditingController();
  final TextEditingController _nuevoPersonajeOdiado = TextEditingController();

  double _amor = 0;
  double _gracioso = 0;
  double _enojo = 0;
  double _tristeza = 0;
  double _fantasia = 0;
  double _reflexion = 0;
  double _spicy = 0;
  double _trama = 0;
  double _asesinato = 0;
  double _finalLibro = 0;

  final List<String> _frasesFavoritas = [];
  final TextEditingController _nuevaFrase = TextEditingController();

  void _agregarPersonajeFav() {
    if (_nuevoPersonajeFav.text.isNotEmpty) {
      setState(() {
        _personajesFavoritos.add(_nuevoPersonajeFav.text);
        _nuevoPersonajeFav.clear();
      });
    }
  }

  void _agregarPersonajeOdiado() {
    if (_nuevoPersonajeOdiado.text.isNotEmpty) {
      setState(() {
        _personajesOdiados.add(_nuevoPersonajeOdiado.text);
        _nuevoPersonajeOdiado.clear();
      });
    }
  }

  void _agregarFrase() {
    if (_nuevaFrase.text.isNotEmpty) {
      setState(() {
        _frasesFavoritas.add(_nuevaFrase.text);
        _nuevaFrase.clear();
      });
    }
  }

  void _guardarReview() {
    final review = Review(
      resena: _resenaController.text,
      personajesFavoritos: _personajesFavoritos,
      personajesOdiados: _personajesOdiados,
      amor: _amor,
      gracioso: _gracioso,
      enojo: _enojo,
      tristeza: _tristeza,
      fantasia: _fantasia,
      reflexion: _reflexion,
      spicy: _spicy,
      trama: _trama,
      asesinato: _asesinato,
      finalLibro: _finalLibro,
      frasesFavoritas: _frasesFavoritas,
    );
    widget.onReviewComplete(review);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _resenaController.dispose();
    _nuevoPersonajeFav.dispose();
    _nuevoPersonajeOdiado.dispose();
    _nuevaFrase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Detallada'),
        backgroundColor: const Color(0xFF5D4037),
        centerTitle: true,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Review del Libro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _resenaController,
                maxLines: null,
                minLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Escribe tu review aqui... (sin limite de caracteres)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              _buildPersonajesSection(
                titulo: 'Personajes Favoritos',
                personajes: _personajesFavoritos,
                controller: _nuevoPersonajeFav,
                onAdd: _agregarPersonajeFav,
                icon: Icons.favorite,
              ),
              const SizedBox(height: 24),
              _buildPersonajesSection(
                titulo: 'Personajes Odiados',
                personajes: _personajesOdiados,
                controller: _nuevoPersonajeOdiado,
                onAdd: _agregarPersonajeOdiado,
                icon: Icons.thumb_down,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              const Text(
                'Calificaciones del Libro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 16),
              _buildEmotionRating('Amor', _amor, (v) => setState(() => _amor = v)),
              _buildEmotionRating('Gracioso', _gracioso, (v) => setState(() => _gracioso = v)),
              _buildEmotionRating('Enojo', _enojo, (v) => setState(() => _enojo = v)),
              _buildEmotionRating('Tristeza', _tristeza, (v) => setState(() => _tristeza = v)),
              _buildEmotionRating('Fantasia', _fantasia, (v) => setState(() => _fantasia = v)),
              _buildEmotionRating('Reflexion', _reflexion, (v) => setState(() => _reflexion = v)),
              _buildEmotionRating('Spicy', _spicy, (v) => setState(() => _spicy = v)),
              _buildEmotionRating('Trama', _trama, (v) => setState(() => _trama = v)),
              _buildEmotionRating('Asesinato', _asesinato, (v) => setState(() => _asesinato = v)),
              _buildEmotionRating('Final', _finalLibro, (v) => setState(() => _finalLibro = v)),
              const SizedBox(height: 24),
              const Text(
                'Frases Favoritas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nuevaFrase,
                      decoration: const InputDecoration(
                        hintText: 'Escribe una frase...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Color(0xFF558B2F), size: 40),
                    onPressed: _agregarFrase,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._frasesFavoritas.map((frase) => Card(
                    margin: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(Icons.format_quote),
                      title: Text(frase),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _frasesFavoritas.remove(frase);
                          });
                        },
                      ),
                    ),
                  )),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _guardarReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF558B2F),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'GUARDAR REVIEW',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonajesSection({
    required String titulo,
    required List<String> personajes,
    required TextEditingController controller,
    required VoidCallback onAdd,
    required IconData icon,
    Color color = Colors.green,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D4037),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Agregar personaje...',
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(icon, color: color),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add_circle, color: color, size: 40),
              onPressed: onAdd,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: personajes.map((p) => Chip(
                label: Text(p),
                avatar: Icon(icon, size: 18, color: color),
                onDeleted: () {
                  setState(() {
                    personajes.remove(p);
                  });
                },
              )).toList(),
        ),
      ],
    );
  }

  Widget _buildEmotionRating(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        StarRating(rating: value, onRatingChanged: onChanged, size: 35),
        const SizedBox(height: 16),
      ],
    );
  }
}