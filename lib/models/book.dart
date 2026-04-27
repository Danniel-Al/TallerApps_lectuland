//Importación de materiales de diseño como iconos, color
import 'package:flutter/material.dart';

class Book { // Definir el tipo de datos de las variables para hacer reseña
  final String id; //Identificador del libro
  final String titulo; //Nombre del liro
  final String autor; //Nombre del autor
  final String? imagenUrl; //Dirección web de la portada (opcional)
  final TipoLibro tipo; //Formato libro (opción multiple)
  final int paginas; //Número de páginas
  final String idioma; //Idioma del libro
  final double calificacion; //Puntuación del libro
  final DateTime fechaInicio; //Día que se empezó a leer el libro
  final DateTime fechaFin; // Día que se terminó de leer el libro
  final String generoLiterario; //Categoría del libro
  final TipoSerie tipoSerie; //Tipo de serie (opción multiple)
  final Review review; //Contenido de reseña 
  final EstadoLectura estadoLectura; //Estado de lectura (opción multiple)

  Book({ // Parámetros nombrados al crear un libro
    required this.id,
    required this.titulo,
    required this.autor,
    this.imagenUrl,
    required this.tipo,
    required this.paginas,
    required this.idioma,
    this.calificacion = 0, //Valor por defecto "0"
    required this.fechaInicio,
    required this.fechaFin,
    required this.generoLiterario,
    required this.tipoSerie,
    required this.review,
    this.estadoLectura = EstadoLectura.leido, //Valor por defecto será "Leído"
  });
}

class Review {
  final String resena; //Texto largo con la reseña del libro 
  final List<String> personajesFavoritos; // Lista de personajes favoritos
  final List<String> personajesOdiados; //Lista de personajes odiados
  final double amor; //Calificación de 0 a 5 respecto a romance
  final double gracioso; //Calificación de 0 a 5 respecto a humor
  final double enojo; //Calificación de 0 a 5 respecto al enojo que provocó
  final double tristeza; //Calificación de 0 a 5 respecto a lo triste que es
  final double fantasia; //Calificación de 0 a 5 respecto a los elementos fantásticos
  final double reflexion; //Calificación de 0 a 5 respecto a lo que te hizo pensar
  final double spicy; //Calificación de 0 a 5 respecto al contenido adulto
  final double trama; //Calificación de 0 a 5 respecto a la historia
  final double asesinato; //Calificación de 0 a 5 respecto a la violencia
  final double finalLibro; //Lista de frases destacadas al desenlace
  final List<String> frasesFavoritas; //Lista de frases destacadas

  Review({ //Valores por defectos
    this.resena = '',
    this.personajesFavoritos = const [], //Lista vacía
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

enum EstadoLectura { //Lista de opciones para identicicar el estado de lectura
  porLeer,
  leyendo,
  leido;

  @override
  String toString() { //Se reemplaa el método por defecto para devolver el texto con emojis
    switch (this) {
      case EstadoLectura.porLeer:
        return '📖 Por leer';
      case EstadoLectura.leyendo:
        return '📚 Leyendo';
      case EstadoLectura.leido:
        return '✅ Leído';
    }
  }

  IconData get icon { //Se crea propiedad al usar el icono
    switch (this) { //cada estado tiene un ícono diferente
      case EstadoLectura.porLeer:
        return Icons.bookmark_border;
      case EstadoLectura.leyendo:
        return Icons.book;
      case EstadoLectura.leido:
        return Icons.check_circle;
    }
  }

  Color get color { //Se crea propiedad para devolver un color según el estado de la lectura
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

enum TipoLibro { //Tres  formatos posibles del tipo de libro
  electronico,
  tapaDura,
  tapaBlanda;

  @override
  String toString() { //Convierte cada opción a un texto legible
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

enum TipoSerie { //Convierte cada opción en un texto legible
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