class Libro {
  final int? id;
  final String tituloLibro;
  final String autor;
  final int anio;

  Libro({this.id, required this.tituloLibro, required this.autor, required this.anio});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': tituloLibro,
      'autor': autor,
      'anio': anio,
    };
  }
}
