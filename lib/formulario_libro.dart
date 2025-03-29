import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'libros.dart';

class FormularioLibro extends StatefulWidget {
  @override
  _FormularioLibroState createState() => _FormularioLibroState();
}

class _FormularioLibroState extends State<FormularioLibro> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController anioController = TextEditingController();

  void guardarLibro() async {
    if (tituloController.text.isNotEmpty &&
        autorController.text.isNotEmpty &&
        anioController.text.isNotEmpty) {
      
      final nuevoLibro = Libro(
        tituloLibro: tituloController.text,
        autor: autorController.text,
        anio: int.parse(anioController.text),
      );

      await dbHelper.insertLibro(nuevoLibro);
      Navigator.pop(context, true); // Indicar que se guardó correctamente
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Libro 📖')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloController,
                  decoration: InputDecoration(labelText: 'Título del Libro'),
                ),
                TextField(
                  controller: autorController,
                  decoration: InputDecoration(labelText: 'Autor'),
                ),
                TextField(
                  controller: anioController,
                  decoration: InputDecoration(labelText: 'Año de Publicación'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: guardarLibro,
                  child: Text('Guardar Libro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
