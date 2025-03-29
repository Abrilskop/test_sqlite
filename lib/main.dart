import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'libros.dart';
import 'formulario_libro.dart';

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Libro> libros = [];

  @override
  void initState() {
    super.initState();
    cargarLibros();
  }

  void cargarLibros() async {
    List<Libro> lista = await dbHelper.obtenerLibros();
    setState(() {
      libros = lista;
    });
  }

  void mostrarFormularioAgregar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormularioLibro()),
    ).then((resultado) {
      if (resultado == true) {
        cargarLibros(); // Recargar la lista si se guardó un libro
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mi Biblioteca 📚')),
      body: libros.isEmpty
          ? Center(child: Text('No hay libros aún. Agrega uno! 📖'))
          : ListView.builder(
              itemCount: libros.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 5,
                  child: ListTile(
                    title: Text(libros[index].tituloLibro,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Autor: ${libros[index].autor} | Año: ${libros[index].anio}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarFormularioAgregar,
        child: Icon(Icons.add),
      ),
    );
  }
}
