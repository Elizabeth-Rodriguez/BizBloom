import 'dart:convert';

class Negocio {
  final int? id; // Nuevo campo opcional
  final String nombreNegocio;
  final String campo;
  final String descripcion;
  final String nombreProducto;
  final List<MaterialProducto> materiales;
  final double costosFijos;
  final double margenGanancia;

  Negocio({
    this.id,
    required this.nombreNegocio,
    required this.campo,
    required this.descripcion,
    required this.nombreProducto,
    required this.materiales,
    required this.costosFijos,
    required this.margenGanancia,
  });

  // MÉTODOS DE CÁLCULO
  double calcularCostoTotal() {
    double costoMateriales = materiales.fold(
        0.0, (suma, m) => suma + (m.cantidad * m.costoUnitario));
    return costoMateriales + costosFijos;
  }

  double calcularPrecioVenta() {
    double costo = calcularCostoTotal();
    return costo + (costo * (margenGanancia / 100));
  }

  double calcularCostoVariableUnitario() {
    return materiales.fold(
        0.0, (suma, m) => suma + (m.cantidad * m.costoUnitario));
  }

  double calcularPuntoEquilibrioUnidades() {
    double costoVariable = calcularCostoVariableUnitario();
    double precioVenta = calcularPrecioVenta();
    return costosFijos / (precioVenta - costoVariable);
  }

  // CONVERSIÓN A MAPA (para SQLite)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nombreNegocio': nombreNegocio,
      'campo': campo,
      'descripcion': descripcion,
      'nombreProducto': nombreProducto,
      'materiales': jsonEncode(materiales.map((m) => m.toMap()).toList()),
      'costosFijos': costosFijos,
      'margenGanancia': margenGanancia,
    };
  }

  // CONVERSIÓN DESDE MAPA
  factory Negocio.fromMap(Map<String, dynamic> map) {
    return Negocio(
      id: map['id'],
      nombreNegocio: map['nombreNegocio'],
      campo: map['campo'],
      descripcion: map['descripcion'],
      nombreProducto: map['nombreProducto'],
      materiales: (jsonDecode(map['materiales']) as List)
          .map((m) => MaterialProducto.fromMap(m))
          .toList(),
      costosFijos: (map['costosFijos'] is int)
          ? (map['costosFijos'] as int).toDouble()
          : map['costosFijos'],
      margenGanancia: (map['margenGanancia'] is int)
          ? (map['margenGanancia'] as int).toDouble()
          : map['margenGanancia'],
    );
  }
}

class MaterialProducto {
  final String nombre;
  final double cantidad;
  final String unidad;
  final double costoUnitario;

  MaterialProducto({
    required this.nombre,
    required this.cantidad,
    required this.unidad,
    required this.costoUnitario,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'cantidad': cantidad,
      'unidad': unidad,
      'costoUnitario': costoUnitario,
    };
  }

  factory MaterialProducto.fromMap(Map<String, dynamic> map) {
    return MaterialProducto(
      nombre: map['nombre'],
      cantidad: (map['cantidad'] is int)
          ? (map['cantidad'] as int).toDouble()
          : map['cantidad'],
      unidad: map['unidad'],
      costoUnitario: (map['costoUnitario'] is int)
          ? (map['costoUnitario'] as int).toDouble()
          : map['costoUnitario'],
    );
  }
}
