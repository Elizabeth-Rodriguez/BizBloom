import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/negocio.dart';

class InformeScreen extends StatelessWidget {
  final Negocio negocio;

  const InformeScreen({super.key, required this.negocio});

  @override
  Widget build(BuildContext context) {
    double costoTotal = negocio.calcularCostoTotal();
    double precioVenta = negocio.calcularPrecioVenta();
    double puntoEquilibrio = negocio.calcularPuntoEquilibrioUnidades();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informe',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(  // Centra todo el contenido en el centro
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centra los elementos horizontalmente
              children: [
                Text(
                  'Nombre del negocio: ${negocio.nombreNegocio}',
                  style: GoogleFonts.montserrat(fontSize: 18),
                  textAlign: TextAlign.center,  // Asegura que el texto esté centrado
                ),
                const SizedBox(height: 8),
                Text(
                  'Producto: ${negocio.nombreProducto}',
                  style: GoogleFonts.montserrat(fontSize: 18),
                  textAlign: TextAlign.center,  // Asegura que el texto esté centrado
                ),
                const SizedBox(height: 16),
                Text(
                  'Costo Total: \$${costoTotal.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(fontSize: 18),
                  textAlign: TextAlign.center,  // Asegura que el texto esté centrado
                ),
                const SizedBox(height: 8),
                Text(
                  'Precio de Venta: \$${precioVenta.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(fontSize: 18),
                  textAlign: TextAlign.center,  // Asegura que el texto esté centrado
                ),
                const SizedBox(height: 8),
                Text(
                  'Punto de Equilibrio: ${puntoEquilibrio.toStringAsFixed(2)} unidades',
                  style: GoogleFonts.montserrat(fontSize: 18),
                  textAlign: TextAlign.center,  // Asegura que el texto esté centrado
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Navega a la pantalla de inicio al presionar "Finalizar"
                    Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEAD69E),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Finalizar',
                    style: GoogleFonts.montserrat(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
