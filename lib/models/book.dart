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
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'imagenUrl': imagenUrl,
      'tipo': tipo.toString(),
      'paginas': paginas,
      'idioma': idioma,
      'calificacion': calificacion,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'generoLiterario': generoLiterario,
      'tipoSerie': tipoSerie.toString(),
      'review': review.toMap(),
    };
  }
}

class Review {
  final String resena; // Cambiado: reseña -> resena (sin ñ)
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
    this.resena = '', // Cambiado
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

  Map<String, dynamic> toMap() {
    return {
      'resena': resena, // Cambiado
      'personajesFavoritos': personajesFavoritos,
      'personajesOdiados': personajesOdiados,
      'amor': amor,
      'gracioso': gracioso,
      'enojo': enojo,
      'tristeza': tristeza,
      'fantasia': fantasia,
      'reflexion': reflexion,
      'spicy': spicy,
      'trama': trama,
      'asesinato': asesinato,
      'finalLibro': finalLibro,
      'frasesFavoritas': frasesFavoritas,
    };
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
  biologia,
  trilogia;

  @override
  String toString() {
    switch (this) {
      case TipoSerie.autoconclusivo:
        return 'Autoconclusivo';
      case TipoSerie.saga:
        return 'Saga';
      case TipoSerie.biologia:
        return 'Biologia (2 libros)';
      case TipoSerie.trilogia:
        return 'Trilogia';
    }
  }
}