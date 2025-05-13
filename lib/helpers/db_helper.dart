import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/negocio.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'bizbloom.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE negocios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombreNegocio TEXT,
        campo TEXT,
        descripcion TEXT,
        nombreProducto TEXT,
        materiales TEXT,
        costosFijos REAL,
        margenGanancia REAL
      )
    ''');
  }

  Future<int> insertarNegocio(Negocio negocio) async {
    final db = await database;
    return await db.insert('negocios', negocio.toMap());
  }

  Future<List<Negocio>> obtenerNegocios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('negocios');

    return List.generate(maps.length, (i) {
      return Negocio.fromMap(maps[i]);
    });
  }

  Future<Negocio?> obtenerNegocioPorId(int id) async {
    final db = await database;
    final maps = await db.query('negocios', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Negocio.fromMap(maps.first);
    }
    return null;
  }

  Future<void> eliminarNegocioPorId(int id) async {
    final db = await database;
    await db.delete('negocios', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> eliminarTodos() async {
    final db = await database;
    await db.delete('negocios');
  }
}
