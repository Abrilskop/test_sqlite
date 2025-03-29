import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'libros.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await inicializarDB();
    return _database!;
  }

  Future<Database> inicializarDB() async {
    String path = join(await getDatabasesPath(), 'biblioteca.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE libros(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertLibro(Libro libro) async {
    final db = await database;
    await db.insert('libros', libro.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Libro>> obtenerLibros() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('libros');
    return List.generate(maps.length, (i) {
      return Libro(
        id: maps[i]['id'],
        tituloLibro: maps[i]['titulo'],
      );
    });
  }
}