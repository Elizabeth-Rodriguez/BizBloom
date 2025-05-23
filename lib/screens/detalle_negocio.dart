import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/negocio.dart';
import '../widgets/base_screen.dart';
import '../widgets/equilibrio_chart.dart';
import '../helpers/db_helper.dart'; // Asegúrate de importar correctamente

class DetalleNegocioScreen extends StatelessWidget {
  const DetalleNegocioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negocio = ModalRoute.of(context)!.settings.arguments as Negocio;
    final puntoEquilibrio = negocio.calcularPuntoEquilibrioUnidades();
    final costoTotal = negocio.calcularCostoTotal();
    final precioVenta = negocio.calcularPrecioVenta();

    const double titleSize = 28;
    const double fontSize = 16;

    return BaseScreen(
      title: 'Detalle de Negocio',
      showBack: true,
      showBottomBar: false,
      showSkip: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                negocio.nombreNegocio,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tu negocio',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Campo: ${negocio.campo}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    const SizedBox(height: 4),
                    Text('Descripción: ${negocio.descripcion}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    const Divider(height: 30, thickness: 1),
                    Text('Tu Producto',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Producto: ${negocio.nombreProducto}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Costo: \$${costoTotal.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Precio: \$${precioVenta.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text(
                        'Margen de Ganancia: ${negocio.margenGanancia.toStringAsFixed(2)}%',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    const Divider(height: 30, thickness: 1),
                    Text('Materiales',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: negocio.materiales.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 12, color: Colors.grey),
                      itemBuilder: (context, index) {
                        final material = negocio.materiales[index];
                        return Text(
                          '${material.nombre} - Cantidad: ${material.cantidad}, Precio unitario: \$${material.costoUnitario.toStringAsFixed(2)}',
                          style:
                              GoogleFonts.montserrat(fontSize: fontSize),
                        );
                      },
                    ),
                    const Divider(height: 30, thickness: 1),
                    Text('Punto de Equilibrio',
    style: GoogleFonts.montserrat(
        fontSize: fontSize, fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Text(
  'Unidades necesarias para alcanzar el punto de equilibrio: ${puntoEquilibrio.ceil()}',
  style: GoogleFonts.montserrat(fontSize: fontSize),
),
const SizedBox(height: 16),
EquilibrioChart(
  negocio: negocio,
  puntoEquilibrio: puntoEquilibrio,
  chartWidth: MediaQuery.of(context).size.width * 0.8,
),


                    const SizedBox(height: 24),
                    
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
  onPressed: () async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white, 
        title: const Text("¿Eliminar negocio?",
        style: TextStyle(color: Colors.brown),),
        content: const Text(
            "¿Deseas eliminar este negocio? Esta acción no se puede deshacer.",
        style: TextStyle(color: Colors.brown),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancelar",
        style: TextStyle(color: Colors.brown),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Eliminar",
        style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DBHelper().eliminarNegocioPorId(negocio.id!);
      Navigator.pop(context); // Regresar a la pantalla anterior
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white, // Fondo blanco
    foregroundColor: Colors.red, // Texto rojo
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Colors.red, width: 1), // Borde rojo
    ),
  ),
  icon: const Icon(Icons.delete, color: Colors.red), // Icono rojo
  label: const Text(
    "Eliminar negocio",
    style: TextStyle(color: Colors.red), // Texto rojo
  ),
)

          ],
        ),
      ),
    );
  }
}

