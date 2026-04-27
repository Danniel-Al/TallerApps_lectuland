import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'review_screen.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;

  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _tituloController;
  late final TextEditingController _autorController;
  late final TextEditingController _paginasController;
  late final TextEditingController _idiomaController;
  late final TextEditingController _generoController;

  late TipoLibro _tipoSeleccionado;
  late DateTime _fechaInicio;
  late DateTime _fechaFin;
  late TipoSerie _tipoSerieSeleccionado;
  late EstadoLectura _estadoLecturaSeleccionado;
  late double _calificacion;
  late String? _imagenUrl;
  late Review _reviewGuardado;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.book.titulo);
    _autorController = TextEditingController(text: widget.book.autor);
    _paginasController = TextEditingController(text: widget.book.paginas.toString());
    _idiomaController = TextEditingController(text: widget.book.idioma);
    _generoController = TextEditingController(text: widget.book.generoLiterario);
    _tipoSeleccionado = widget.book.tipo;
    _fechaInicio = widget.book.fechaInicio;
    _fechaFin = widget.book.fechaFin;
    _tipoSerieSeleccionado = widget.book.tipoSerie;
    _estadoLecturaSeleccionado = widget.book.estadoLectura;
    _calificacion = widget.book.calificacion;
    _imagenUrl = widget.book.imagenUrl;
    _reviewGuardado = widget.book.review;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final libroActualizado = Book(
        id: widget.book.id,
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
        review: _reviewGuardado,
        estadoLectura: _estadoLecturaSeleccionado,
      );

      BookService.updateBook(libroActualizado);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Libro actualizado: ${libroActualizado.titulo}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context, true);
    }
  }

  void _editarReview() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          existingReview: _reviewGuardado,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Libro'),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Editar Informacion del Libro',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 20),

                // Estado de lectura
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

                TextFormField(
                  controller: _idiomaController,
                  decoration: const InputDecoration(
                    labelText: 'Idioma',
                    prefixIcon: Icon(Icons.language),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa el idioma';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _generoController,
                  decoration: const InputDecoration(
                    labelText: 'Genero literario',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa el genero literario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

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

                TextFormField(
                  initialValue: _imagenUrl,
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

                ElevatedButton.icon(
                  onPressed: _editarReview,
                  icon: const Icon(Icons.rate_review),
                  label: const Text('EDITAR REVIEW'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D6E63),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),

                const SizedBox(height: 20),

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
                    'GUARDAR CAMBIOS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}