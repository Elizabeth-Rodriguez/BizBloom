import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../models/negocio.dart';
import '../helpers/db_helper.dart';
import '../widgets/base_screen.dart';
import '../widgets/equilibrio_chart.dart';

class InformeScreen extends StatefulWidget {
  final Negocio negocio;

  const InformeScreen({super.key, required this.negocio});

  @override
  _InformeScreenState createState() => _InformeScreenState();
}

class _InformeScreenState extends State<InformeScreen> {
  late Negocio negocio;

  @override
  void initState() {
    super.initState();
    negocio = widget.negocio;
  }

  void _mostrarInfo() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('¿Qué es el Punto de Equilibrio?', style: TextStyle(color: Colors.brown),),
        content: const Text(
            'El Punto de Equilibrio es la cantidad mínima de unidades que debes vender para cubrir tus costos sin obtener pérdidas ni ganancias.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cerrar', style: TextStyle(color: Colors.brown)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double costoUnitario= negocio.calcularCostoVariableUnitario();
    double precioVenta = negocio.CalcularPrecioUsuario();
    double puntoEquilibrio = negocio.calcularPuntoEquilibrioUnidades();
    double precioSugerido = negocio.CalcularPrecioSugerido();
   

    return BaseScreen(
      title: 'Informe',
      showBack: true,
      showBottomBar: false,
      showSkip: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          final horizontalPadding = isWide ? 64.0 : 16.0;
          final fontSize = isWide ? 20.0 : 16.0;
          final titleSize = isWide ? 30.0 : 24.0;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      negocio.nombreNegocio,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                    const SizedBox(height: 10),
                    Text('Campo: ${negocio.campo}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Descripción: ${negocio.descripcion}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                        const Divider(height: 30, thickness: 1),     

                    Text('Tu Producto',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Producto: ${negocio.nombreProducto}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                        Text(
                        'Margen de Ganancia: ${negocio.margenGanancia.toStringAsFixed(2)}%',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text(
                        'Ganancia: \$${negocio.calcularGananciaPesos()}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),

                    Text('Costo unitario: \$${costoUnitario.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                        
                    
                    Text('Precio: \$${precioVenta.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),

                    const Divider(height: 30, thickness: 1),//SUGERENCIA

                    Text('Sugerencia',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                        'Margen de Ganancia: 200%',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text(
                        'Ganancia: \$${negocio.calcularGananciaSugerida()}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Precio Sugerido: \$${precioSugerido.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),

                          const Divider(height: 30, thickness: 1),
                          
                          Text('Análisis Clave',
                              style: GoogleFonts.montserrat(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(
                            'Punto de Equilibrio: ${puntoEquilibrio.toStringAsFixed(2)} unidades',//Ya no redondea!
                                 style: GoogleFonts.montserrat(fontSize: fontSize)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child:
                      Text('Gráfica de Punto de Equilibrio',
                          style: GoogleFonts.montserrat(
                              fontSize:fontSize,
                              fontWeight: FontWeight.w600)), 
                              ),
                    
                      IconButton(
                        icon: const Icon(Icons.info_outline, color: Colors.brown,),
                        onPressed: _mostrarInfo,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  EquilibrioChart(
                    puntoEquilibrio: puntoEquilibrio,
                    chartWidth: constraints.maxWidth - horizontalPadding * 2,
                    negocio: negocio,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.pushNamed(context,'/inicio');
                      },
                      icon: const Icon(Icons.check),
                      label: Text(
                        'Finalizar',
                        style: GoogleFonts.montserrat(fontSize: fontSize),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEAD69E),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}