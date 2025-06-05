import 'dart:convert';

class Negocio {
  final int? id;
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

  // COSTO VARIABLE UNITARIO (suma solo materiales)
  double calcularCostoVariableUnitario() {
    return materiales.fold(
      0.0, (suma, m) => suma + (m.cantidad * m.costoUnitario));
  }

  // PRECIO DE VENTA UNITARIO (sobre costo variable, sin incluir costos fijos)
  double CalcularPrecioUsuario() {
    double costoVariable = calcularCostoVariableUnitario();
    return costoVariable + (costoVariable * (margenGanancia / 100));
  }

double CalcularPrecioSugerido() {
    double costoVariable = calcularCostoVariableUnitario();
    return costoVariable + (costoVariable * 2);
  }

  // COSTO TOTAL (materiales + costos fijos)
  double calcularCostoTotal() {
    double costoMateriales = calcularCostoVariableUnitario();
    return costoMateriales + costosFijos;
  }

  // PUNTO DE EQUILIBRIO EN UNIDADES
  double calcularPuntoEquilibrioUnidades() {
    double costoVariable = calcularCostoVariableUnitario();
    double precioVenta = CalcularPrecioUsuario();
    double margenContribucion = precioVenta - costoVariable;
    if (margenContribucion <= 0) {
      return 0;
    }
    return costosFijos / margenContribucion;
  }

double calcularGananciaPesos() {
  return CalcularPrecioUsuario() - calcularCostoVariableUnitario();
}

double calcularGananciaSugerida() {
  return CalcularPrecioSugerido() - calcularCostoVariableUnitario();
}

  Negocio copyWith({
    int? id,
    String? nombreNegocio,
    String? campo,
    String? descripcion,
    String? nombreProducto,
    List<MaterialProducto>? materiales,
    double? costosFijos,
    double? margenGanancia,
  }) {
    return Negocio(
      id: id ?? this.id,
      nombreNegocio: nombreNegocio ?? this.nombreNegocio,
      campo: campo ?? this.campo,
      descripcion: descripcion ?? this.descripcion,
      nombreProducto: nombreProducto ?? this.nombreProducto,
      materiales: materiales ?? this.materiales,
      costosFijos: costosFijos ?? this.costosFijos,
      margenGanancia: margenGanancia ?? this.margenGanancia,
    );
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
      costosFijos: _toDouble(map['costosFijos']),
      margenGanancia: _toDouble(map['margenGanancia']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  String toString() {
    return 'Negocio(id: $id, nombreNegocio: $nombreNegocio, campo: $campo, descripcion: $descripcion, nombreProducto: $nombreProducto, materiales: $materiales, costosFijos: $costosFijos, margenGanancia: $margenGanancia)';
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
      cantidad: _toDouble(map['cantidad']),
      unidad: map['unidad'],
      costoUnitario: _toDouble(map['costoUnitario']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  MaterialProducto copyWith({
    String? nombre,
    double? cantidad,
    String? unidad,
    double? costoUnitario,
  }) {
    return MaterialProducto(
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      unidad: unidad ?? this.unidad,
      costoUnitario: costoUnitario ?? this.costoUnitario,
    );
  }

  @override
  String toString() {
    return 'MaterialProducto(nombre: $nombre, cantidad: $cantidad, unidad: $unidad, costoUnitario: $costoUnitario)';
  }
}
