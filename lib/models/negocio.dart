class Negocio {
  final String nombreNegocio;
  final String campo;
  final String descripcion;
  final String nombreProducto;
  final List<MaterialProducto> materiales;
  final double costosFijos;
  final double margenGanancia;

  Negocio({
    required this.nombreNegocio,
    required this.campo,
    required this.descripcion,
    required this.nombreProducto,
    required this.materiales,
    required this.costosFijos,
    required this.margenGanancia,
  });

  double calcularCostoTotal() {
    double costoMateriales = materiales.fold(
        0.0, (suma, m) => suma + (m.cantidad * m.costoUnitario));
    return costoMateriales + costosFijos;
  }

  double calcularPrecioVenta() {
    double costo = calcularCostoTotal();
    return costo + (costo * (margenGanancia / 100));
  }

  // Dentro de tu clase Negocio
  double calcularCostoVariableUnitario() {
    return materiales.fold(
        0.0, (suma, m) => suma + (m.cantidad * m.costoUnitario));
  }

  double calcularPuntoEquilibrioUnidades() {
    double costoVariable = calcularCostoVariableUnitario();
    double precioVenta = calcularPrecioVenta();
    return costosFijos / (precioVenta - costoVariable);
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
}
