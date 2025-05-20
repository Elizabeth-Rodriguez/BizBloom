import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';
import 'package:intl/intl.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  List<Map<String, dynamic>> materiales = [
    {
      'cantidad': TextEditingController(),
      'costo': TextEditingController(),
      'unidad': 'kg'
    },
  ];

  final TextEditingController costoFijoController = TextEditingController();
  double totalCosto = 0.0;

  void agregarMaterial() {
    setState(() {
      materiales.add({
        'cantidad': TextEditingController(),
        'costo': TextEditingController(),
        'unidad': 'kg',
      });
    });
  }

  void eliminarMaterial(int index) {
    setState(() {
      materiales.removeAt(index);
    });
  }

  void mostrarInfoCostosFijos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          '¿Qué son los costos fijos mensuales?',
          style: TextStyle(color: Colors.brown),
        ),
        content: const Text(
          'Son gastos constantes como renta, servicios, sueldos, etc., que se deben cubrir cada mes, independientemente de la producción.',
          style: TextStyle(color: Colors.brown),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Entendido',
              style: TextStyle(color: Colors.brown),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void calcularCosto() {
    double total = 0.0;
    for (var mat in materiales) {
      double cantidad = double.tryParse(mat['cantidad'].text) ?? 0;
      double costo = double.tryParse(mat['costo'].text.replaceAll('\$', '')) ?? 0;
      total += cantidad * costo;
    }

    double costosFijos = double.tryParse(costoFijoController.text.replaceAll('\$', '')) ?? 0;
    total += costosFijos;

    setState(() {
      totalCosto = total;
    });
  }

  String formatear(double valor) {
    return NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(valor);
  }

  Widget construirMaterial(int index) {
    final material = materiales[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Material',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.black),
                onPressed: () => eliminarMaterial(index),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Cantidad', style: GoogleFonts.montserrat()),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: material['cantidad'],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '0.0',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: material['unidad'],
                items: ['g', 'kg', 'unidad'].map((String unidad) {
                  return DropdownMenuItem<String>(
                    value: unidad,
                    child: Text(unidad),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    material['unidad'] = newValue;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Costo Unitario de Material', style: GoogleFonts.montserrat()),
          const SizedBox(height: 5),
          TextField(
            controller: material['costo'],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '\$0.00',
              hintStyle: TextStyle(fontSize: 20),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (!value.startsWith('\$')) {
                material['costo'].text = '\$${value.replaceAll('\$', '')}';
                material['costo'].selection = TextSelection.fromPosition(
                  TextPosition(offset: material['costo'].text.length),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
      title: 'Calculadora',
      showBack: true,
      showBottomBar: true,
      child: SingleChildScrollView(   // <-- Aquí va el scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Calcula tu costo de producción por unidad',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: size.width * 0.045),
            ),
            const SizedBox(height: 20),
            ...List.generate(materiales.length, construirMaterial),
            ElevatedButton.icon(
              onPressed: agregarMaterial,
              icon: const Icon(Icons.add, color: Colors.black),
              label: Text('Agregar Material',
                  style: GoogleFonts.montserrat(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBDBA9),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Costos Fijos Mensuales', style: GoogleFonts.montserrat()),
                IconButton(
                  icon: const Icon(Icons.info_outline,
                      size: 20, color: Colors.brown),
                  onPressed: mostrarInfoCostosFijos,
                ),
              ],
            ),
            const SizedBox(height: 1),
            TextField(
              controller: costoFijoController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                hintText: '\$0.00',
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (!value.startsWith('\$')) {
                  costoFijoController.text = '\$${value.replaceAll('\$', '')}';
                  costoFijoController.selection = TextSelection.fromPosition(
                    TextPosition(offset: costoFijoController.text.length),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularCosto,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBDBA9),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: Text('Calcular',
                  style: GoogleFonts.montserrat(color: Colors.black)),
            ),
            const SizedBox(height: 20),
            Text('El costo unitario de tu producto es de:',
                style: GoogleFonts.montserrat()),
            const SizedBox(height: 10),
            Text(
              formatear(totalCosto),
              style: GoogleFonts.montserrat(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
