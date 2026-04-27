import 'package:flutter/material.dart';

class Book {
  final String id;
  final String titulo;
  final String autor;
  final String? imagenUrl;
  final TipoLibro tipo;
  final int paginas;
  final String idioma;
  final double calificacion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String generoLiterario;
  final TipoSerie tipoSerie;
  final Review review;
  final EstadoLectura estadoLectura;

  Book({
    required this.id,
    required this.titulo,
    required this.autor,
    this.imagenUrl,
    required this.tipo,
    required this.paginas,
    required this.idioma,
    this.calificacion = 0,
    required this.fechaInicio,
    required this.fechaFin,
    required this.generoLiterario,
    required this.tipoSerie,
    required this.review,
    this.estadoLectura = EstadoLectura.leido,
  });
}

class Review {
  final String resena;
  final List<String> personajesFavoritos;
  final List<String> personajesOdiados;
  final double amor;
  final double gracioso;
  final double enojo;
  final double tristeza;
  final double fantasia;
  final double reflexion;
  final double spicy;
  final double trama;
  final double asesinato;
  final double finalLibro;
  final List<String> frasesFavoritas;

  Review({
    this.resena = '',
    this.personajesFavoritos = const [],
    this.personajesOdiados = const [],
    this.amor = 0,
    this.gracioso = 0,
    this.enojo = 0,
    this.tristeza = 0,
    this.fantasia = 0,
    this.reflexion = 0,
    this.spicy = 0,
    this.trama = 0,
    this.asesinato = 0,
    this.finalLibro = 0,
    this.frasesFavoritas = const [],
  });
}

enum EstadoLectura {
  porLeer,
  leyendo,
  leido;

  @override
  String toString() {
    switch (this) {
      case EstadoLectura.porLeer:
        return '📖 Por leer';
      case EstadoLectura.leyendo:
        return '📚 Leyendo';
      case EstadoLectura.leido:
        return '✅ Leído';
    }
  }

  IconData get icon {
    switch (this) {
      case EstadoLectura.porLeer:
        return Icons.bookmark_border;
      case EstadoLectura.leyendo:
        return Icons.book;
      case EstadoLectura.leido:
        return Icons.check_circle;
    }
  }

  Color get color {
    switch (this) {
      case EstadoLectura.porLeer:
        return Colors.orange;
      case EstadoLectura.leyendo:
        return Colors.blue;
      case EstadoLectura.leido:
        return Colors.green;
    }
  }
}

enum TipoLibro {
  electronico,
  tapaDura,
  tapaBlanda;

  @override
  String toString() {
    switch (this) {
      case TipoLibro.electronico:
        return 'Electronico';
      case TipoLibro.tapaDura:
        return 'Tapa dura';
      case TipoLibro.tapaBlanda:
        return 'Tapa blanda';
    }
  }
}

enum TipoSerie {
  autoconclusivo,
  saga,
  bilogia,
  trilogia;

  @override
  String toString() {
    switch (this) {
      case TipoSerie.autoconclusivo:
        return 'Autoconclusivo';
      case TipoSerie.saga:
        return 'Saga';
      case TipoSerie.bilogia:
        return 'Bilogia (2 libros)';
      case TipoSerie.trilogia:
        return 'Trilogia';
    }
  }
}