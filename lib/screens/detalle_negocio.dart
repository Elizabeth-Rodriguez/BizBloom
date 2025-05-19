import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/negocio.dart';
import '../widgets/base_screen.dart';
import '../widgets/equilibrio_chart.dart';

class DetalleNegocioScreen extends StatelessWidget {
  const DetalleNegocioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negocio = ModalRoute.of(context)!.settings.arguments as Negocio;

    final puntoEquilibrio = negocio.calcularPuntoEquilibrioUnidades();

    // Asumo que tienes estos métodos/calculados:
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
                    Text('Margen de Ganancia: ${negocio.margenGanancia.toStringAsFixed(2)}%',
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
                          style: GoogleFonts.montserrat(fontSize: fontSize),
                        );
                      },
                    ),
                    const Divider(height: 30, thickness: 1),
                    Text('Análisis Clave',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      'Punto de Equilibrio: ${puntoEquilibrio.toStringAsFixed(2)} unidades',
                      style: GoogleFonts.montserrat(fontSize: fontSize),
                    ),
                    Text(
              'Costos fijos: \$${negocio.costosFijos.toStringAsFixed(2)}',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Margen de ganancia: ${negocio.margenGanancia.toStringAsFixed(2)}%',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            Center(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Punto de Equilibrio',
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(width: 6),
      IconButton(
        icon: const Icon(Icons.info_outline, color: Colors.black),
        iconSize: 20,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('¿Qué es el Punto de Equilibrio?',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                content: Text(
                  'El punto de equilibrio es la cantidad mínima de unidades que debes vender para cubrir tus costos sin perder dinero.',
                  style: GoogleFonts.montserrat(),
                ),
                actions: [
                  TextButton(
                    child: Text('Cerrar', style: GoogleFonts.montserrat()),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  ),
),


            EquilibrioChart(
              puntoEquilibrio: puntoEquilibrio,
              chartWidth: MediaQuery.of(context).size.width,
              negocio: negocio,
            ),   
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFD88B6F),
      ),
    );
  }
}

/**import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/negocio.dart';
import '../widgets/base_screen.dart';  // importa tu BaseScreen

class DetalleNegocioScreen extends StatelessWidget {
  const DetalleNegocioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negocio = ModalRoute.of(context)!.settings.arguments as Negocio;

    return BaseScreen(
      title: 'Detalle de Negocio',
      showBack: true,       
      showBottomBar: false, 
      showSkip: false,     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            negocio.nombreNegocio,
            style: GoogleFonts.montserrat(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            negocio.descripcion,
            style: GoogleFonts.montserrat(fontSize: 18),
          ),
          const SizedBox(height: 24),

          Text(
            'Campo:',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            negocio.campo,
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          const SizedBox(height: 24),

          Text(
            'Producto:',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            negocio.nombreProducto,
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          const SizedBox(height: 24),

          Text(
            'Materiales:',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: negocio.materiales.length,
              itemBuilder: (context, index) {
                final material = negocio.materiales[index];
                return ListTile(
                  title: Text(material.nombre),
                  subtitle: Text(
                      'Cantidad: ${material.cantidad}, Precio: \$${material.costoUnitario.toStringAsFixed(2)}'),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Costos fijos: \$${negocio.costosFijos.toStringAsFixed(2)}',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Margen de ganancia: ${negocio.margenGanancia.toStringAsFixed(2)}%',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}
*/