import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/negocio.dart';

class NegocioProvider extends ChangeNotifier {
  final DBHelper _dbHelper = DBHelper();

  List<Negocio> _negocios = [];

  List<Negocio> get negocios => _negocios;

  Future<void> cargarNegocios() async {
    _negocios = await _dbHelper.obtenerNegocios();
    notifyListeners();
  }

  Future<void> agregarNegocio(Negocio negocio) async {
    await _dbHelper.insertarNegocio(negocio);
    await cargarNegocios(); // recarga la lista
  }

  Future<void> eliminarNegocio(int id) async {
    await _dbHelper.eliminarNegocioPorId(id);
    await cargarNegocios(); // recarga la lista
  }

  Future<void> eliminarTodos() async {
    await _dbHelper.eliminarTodos();
    _negocios.clear();
    notifyListeners();
  }
}





/*import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';        // Ajusta la ruta a donde tengas tu DbHelper
import '../models/negocio.dart';   // Ajusta la ruta a donde tengas tu modelo Negocio

class NegocioProvider extends ChangeNotifier {
  final dbHelper dbHelper;
  List<Negocio> _negocios = [];

  List<Negocio> get negocios => _negocios;

  NegocioProvider(this.dbHelper);

  Future<void> cargarNegocios() async {
    _negocios = await dbHelper.obtenerNegocios(); // Este método debe devolver List<Negocio>
    notifyListeners();
  }

  Future<void> agregarNegocio(Negocio negocio) async {
    await dbHelper.insertarNegocio(negocio);     // Método para insertar en la DB
    await cargarNegocios();                        // Recarga la lista
  }

  Future<void> eliminarNegocio(int id) async {
    await dbHelper.eliminarNegocio(id);          // Método para eliminar en DB
    await cargarNegocios();
  }

  // Puedes agregar más métodos como actualizar, etc.
}
*/