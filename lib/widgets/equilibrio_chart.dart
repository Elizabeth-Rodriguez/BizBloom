import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../models/negocio.dart';

class EquilibrioChart extends StatelessWidget {
  final double puntoEquilibrio;
  final double chartWidth;
  final Negocio negocio;

  const EquilibrioChart({
    Key? key,
    required this.puntoEquilibrio,
    required this.chartWidth,
    required this.negocio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.compact();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: chartWidth > 600 ? 2.5 : 1.5,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                axisNameWidget: const Text(
                  'Unidades vendidas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                axisNameSize: 20,
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: puntoEquilibrio / 2,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
              leftTitles: AxisTitles(
                axisNameWidget: const Text(
                  'Ingresos/Costos (\$)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                axisNameSize: 20,
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: negocio.calcularCostoTotal() / 2,
                  reservedSize: 48,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      formatter.format(value),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              horizontalInterval: negocio.calcularCostoTotal() / 2,
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: false,
                color: const Color.fromARGB(255, 216, 139, 111),
                barWidth: 3,
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
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
