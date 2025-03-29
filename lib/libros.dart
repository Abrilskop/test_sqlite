class Libro {
  final int? id;
  final String tituloLibro;

  Libro({this.id, required this.tituloLibro});

  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': tituloLibro};
  }
}