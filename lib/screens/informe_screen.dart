import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/negocio.dart';
import '../helpers/db_helper.dart';
import '../widgets/base_screen.dart'; // Asegúrate de importar la BaseScreen

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

  Widget _buildChart(double puntoEquilibrio, double chartWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: chartWidth > 600 ? 2.5 : 1.5,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: puntoEquilibrio / 5,
                  reservedSize: 25,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(0), 
                      style: const TextStyle(
                        fontSize: 12, 
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: negocio.calcularCostoTotal() / 5,
                  reservedSize: 25,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(0), 
                      style: const TextStyle(
                        fontSize: 12, 
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: true, drawHorizontalLine: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: Colors.orange.shade700,
                barWidth: 4,
                spots: [
                  const FlSpot(0, 0),
                  FlSpot(puntoEquilibrio, negocio.calcularCostoTotal()),
                ],
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 4,
                    color: Colors.black,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.orange.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarInfo() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Qué es el Punto de Equilibrio?'),
        content: const Text(
            'Es el número de unidades que debes vender para cubrir todos tus costos. '
            'Después de este punto, cada venta genera ganancia.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double costoTotal = negocio.calcularCostoTotal();
    double precioVenta = negocio.calcularPrecioVenta();
    double puntoEquilibrio = negocio.calcularPuntoEquilibrioUnidades();

    // Usamos BaseScreen aquí
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
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                 child: Text(
                 negocio.nombreNegocio,
                  style: GoogleFonts.montserrat(
                 fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                   ),
                  ),
                ),
                  Text(
                    'Campo: ${negocio.campo}',
                    style: GoogleFonts.montserrat(fontSize: fontSize),
                  ),
                  Text(
                    'Descripción: ${negocio.descripcion}',
                    style: GoogleFonts.montserrat(fontSize:fontSize),
                  ),

                  const SizedBox(height: 20),
                  //Tarjeta
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
                        children: [
                          Text(
                            'Tu Producto',
                            style: GoogleFonts.montserrat(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                           ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            'Producto: ${negocio.nombreProducto}',
                            style: GoogleFonts.montserrat(fontSize: fontSize),
                          ),
                          Text(
                            'Costo: \$${costoTotal.toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(fontSize: fontSize),
                          ),
                          Text(
                            'Precio: \$${precioVenta.toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(fontSize: fontSize),
                          ),
                          Text(
                            'Margen de Ganancia: ${negocio.margenGanancia}%',
                            style: GoogleFonts.montserrat(fontSize: fontSize),
                          ),
                          Text(
                            'Análisis Clave',
                            style: GoogleFonts.montserrat(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                           ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            'Punto de Equilibrio: ${puntoEquilibrio.toStringAsFixed(2)} unidades',
                            style: GoogleFonts.montserrat(fontSize: fontSize),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gráfica de Punto de Equilibrio',
                        style: GoogleFonts.montserrat(fontSize: fontSize + 2, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: _mostrarInfo,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildChart(puntoEquilibrio, constraints.maxWidth - horizontalPadding * 2),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await DBHelper().insertarNegocio(negocio);
                        Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEAD69E),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Finalizar',
                        style: GoogleFonts.montserrat(fontSize: fontSize),
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
