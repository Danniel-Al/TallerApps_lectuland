import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'review_screen.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _paginasController = TextEditingController();
  final _idiomaController = TextEditingController();
  final _generoController = TextEditingController();

  TipoLibro _tipoSeleccionado = TipoLibro.tapaBlanda;
  DateTime _fechaInicio = DateTime.now();
  DateTime _fechaFin = DateTime.now();
  TipoSerie _tipoSerieSeleccionado = TipoSerie.autoconclusivo;
  EstadoLectura _estadoLecturaSeleccionado = EstadoLectura.leido;
  double _calificacion = 0;
  String? _imagenUrl;

  Review? _reviewGuardado;

  void _limpiarFormulario() {
    _tituloController.clear();
    _autorController.clear();
    _paginasController.clear();
    _idiomaController.clear();
    _generoController.clear();
    setState(() {
      _tipoSeleccionado = TipoLibro.tapaBlanda;
      _fechaInicio = DateTime.now();
      _fechaFin = DateTime.now();
      _tipoSerieSeleccionado = TipoSerie.autoconclusivo;
      _estadoLecturaSeleccionado = EstadoLectura.leido;
      _calificacion = 0;
      _imagenUrl = null;
      _reviewGuardado = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_reviewGuardado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Primero completa la review del libro'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final nuevoLibro = Book(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: _tituloController.text.trim(),
        autor: _autorController.text.trim(),
        imagenUrl: _imagenUrl,
        tipo: _tipoSeleccionado,
        paginas: int.parse(_paginasController.text),
        idioma: _idiomaController.text.trim(),
        calificacion: _calificacion,
        fechaInicio: _fechaInicio,
        fechaFin: _fechaFin,
        generoLiterario: _generoController.text.trim(),
        tipoSerie: _tipoSerieSeleccionado,
        review: _reviewGuardado!,
        estadoLectura: _estadoLecturaSeleccionado,
      );

      BookService.addBook(nuevoLibro);
      _limpiarFormulario();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Libro agregado: ${nuevoLibro.titulo}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Volver a la pantalla principal
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  void _abrirReview() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          onReviewComplete: (review) {
            setState(() {
              _reviewGuardado = review;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _paginasController.dispose();
    _idiomaController.dispose();
    _generoController.dispose();
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Informacion del Libro',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 20),

              // Título
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Titulo del libro',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el titulo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Autor
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el autor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tipo de libro
              DropdownButtonFormField<TipoLibro>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de libro',
                  prefixIcon: Icon(Icons.menu_book),
                  border: OutlineInputBorder(),
                ),
                value: _tipoSeleccionado,
                items: TipoLibro.values.map((tipo) {
                  return DropdownMenuItem<TipoLibro>(
                    value: tipo,
                    child: Text(tipo.toString()),
                  );
                }).toList(),
                onChanged: (TipoLibro? newValue) {
                  setState(() {
                    _tipoSeleccionado = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Número de páginas
              TextFormField(
                controller: _paginasController,
                decoration: const InputDecoration(
                  labelText: 'Numero de paginas',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el numero de paginas';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingresa un numero valido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Idioma
              TextFormField(
                controller: _idiomaController,
                decoration: const InputDecoration(
                  labelText: 'Idioma',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(),
                  hintText: 'Ej: Español, Ingles, Portugues...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el idioma';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Género literario
              TextFormField(
                controller: _generoController,
                decoration: const InputDecoration(
                  labelText: 'Genero literario',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                  hintText: 'Ej: Fantasia, Romance, Terror...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el genero literario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tipo de serie
              DropdownButtonFormField<TipoSerie>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de serie/libro',
                  prefixIcon: Icon(Icons.collections_bookmark),
                  border: OutlineInputBorder(),
                ),
                value: _tipoSerieSeleccionado,
                items: TipoSerie.values.map((tipo) {
                  return DropdownMenuItem<TipoSerie>(
                    value: tipo,
                    child: Text(tipo.toString()),
                  );
                }).toList(),
                onChanged: (TipoSerie? newValue) {
                  setState(() {
                    _tipoSerieSeleccionado = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Estado de lectura (NUEVO)
              DropdownButtonFormField<EstadoLectura>(
                decoration: const InputDecoration(
                  labelText: 'Estado de lectura',
                  prefixIcon: Icon(Icons.bookmark),
                  border: OutlineInputBorder(),
                ),
                value: _estadoLecturaSeleccionado,
                items: EstadoLectura.values.map((estado) {
                  return DropdownMenuItem<EstadoLectura>(
                    value: estado,
                    child: Row(
                      children: [
                        Icon(estado.icon, size: 18, color: estado.color),
                        const SizedBox(width: 8),
                        Text(estado.toString()),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (EstadoLectura? newValue) {
                  setState(() {
                    _estadoLecturaSeleccionado = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Fecha inicio
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.play_arrow, color: Color(0xFF5D4037)),
                title: const Text('Fecha inicio de lectura'),
                subtitle: Text(
                  '${_fechaInicio.day}/${_fechaInicio.month}/${_fechaInicio.year}',
                ),
                onTap: () async {
                  final fecha = await showDatePicker(
                    context: context,
                    initialDate: _fechaInicio,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (fecha != null) {
                    setState(() {
                      _fechaInicio = fecha;
                    });
                  }
                },
              ),
              const SizedBox(height: 8),

              // Fecha fin
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.check_circle, color: Color(0xFF5D4037)),
                title: const Text('Fecha finalización de lectura'),
                subtitle: Text(
                  '${_fechaFin.day}/${_fechaFin.month}/${_fechaFin.year}',
                ),
                onTap: () async {
                  final fecha = await showDatePicker(
                    context: context,
                    initialDate: _fechaFin,
                    firstDate: _fechaInicio,
                    lastDate: DateTime.now(),
                  );
                  if (fecha != null) {
                    setState(() {
                      _fechaFin = fecha;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Calificación
              const Text(
                'Calificacion general (1-5)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _calificacion = index + 1),
                    child: Icon(
                      index < _calificacion ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 50,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // URL portada
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL de la portada (opcional)',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                  hintText: 'https://...',
                ),
                onChanged: (value) {
                  _imagenUrl = value;
                },
              ),
              const SizedBox(height: 20),

              // Botón para review
              ElevatedButton.icon(
                onPressed: _abrirReview,
                icon: const Icon(Icons.rate_review),
                label: Text(
                  _reviewGuardado == null ? 'AGREGAR REVIEW' : 'EDITAR REVIEW',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8D6E63),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              if (_reviewGuardado != null) ...[
                const SizedBox(height: 8),
                const Text(
                  '✓ Review completada',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 20),

              // Botón guardar
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF558B2F),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'GUARDAR LIBRO',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}