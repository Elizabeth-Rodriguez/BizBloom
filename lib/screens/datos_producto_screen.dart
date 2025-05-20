import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../widgets/base_screen.dart';
import '../models/negocio.dart'; // Importante

class DatosProductoScreen extends StatefulWidget {
  const DatosProductoScreen({super.key});

  @override
  State<DatosProductoScreen> createState() => _DatosProductoScreenState();
}

class _DatosProductoScreenState extends State<DatosProductoScreen> {
  late String nombreNegocio;
  late String campo;
  late String descripcion;
  late String nombreProducto;

  List<Map<String, dynamic>> materiales = [
    {
      'nombre': TextEditingController(),
      'cantidad': TextEditingController(),
      'costo': TextEditingController(),
      'unidad': 'kg'
    },
  ];

  final TextEditingController costoFijoController = TextEditingController();
  final TextEditingController margenController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      nombreNegocio = args['nombreNegocio'];
      campo = args['campo'];
      descripcion = args['descripcion'];
      nombreProducto = args['nombreProducto'];
    }
  }

  String formatear(double valor) {
    return NumberFormat.currency(locale: 'es_MX', symbol: '\$')
        .format(valor);
  }

  void mostrarInfoMargen() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, 
        title: const Text('¿Qué es el margen de ganancia?',
        style: TextStyle(color: Colors.brown),),
        content: const Text(
            'Es el porcentaje adicional que se suma al costo de producción para determinar el precio de venta.',
        style: TextStyle(color: Colors.brown),),
        actions: [
          TextButton(
            child: const Text('Entendido',
        style: TextStyle(color: Colors.brown),),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void mostrarInfoCostosFijos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, 
        title: const Text('¿Qué son los costos fijos mensuales?',
        style: TextStyle(color: Colors.brown),),
        content: const Text(
            'Son gastos constantes como renta, servicios, sueldos, etc., que se deben cubrir cada mes.',
        style: TextStyle(color: Colors.brown),),
        actions: [
          TextButton(
            child: const Text('Entendido',
        style: TextStyle(color: Colors.brown),),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
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
                onPressed: () {
                  setState(() {
                    materiales.removeAt(index);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Nombre', style: GoogleFonts.montserrat()),
          const SizedBox(height: 5),
          TextField(
            controller: material['nombre'],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
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
                    material['unidad'] = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Costo Unitario de Material',
              style: GoogleFonts.montserrat()),
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
                material['costo'].text =
                    '\$${value.replaceAll('\$', '')}';
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

  void validarYContinuar() {
    bool camposLlenos = true;

    for (var mat in materiales) {
      if (mat['nombre'].text.isEmpty ||
          mat['cantidad'].text.isEmpty ||
          mat['costo'].text.isEmpty) {
        camposLlenos = false;
        break;
      }
    }

    if (costoFijoController.text.isEmpty ||
        margenController.text.isEmpty) {
      camposLlenos = false;
    }

    if (camposLlenos) {
      List<MaterialProducto> listaMateriales = materiales.map((mat) {
        return MaterialProducto(
          nombre: mat['nombre'].text,
          cantidad: double.tryParse(mat['cantidad'].text) ?? 0.0,
          unidad: mat['unidad'],
          costoUnitario: double.tryParse(
                  mat['costo'].text.replaceAll(RegExp(r'[^\d.]'), '')) ??
              0.0,
        );
      }).toList();

      final negocio = Negocio(
        nombreNegocio: nombreNegocio,
        campo: campo,
        descripcion: descripcion,
        nombreProducto: nombreProducto,
        materiales: listaMateriales,
        costosFijos: double.tryParse(
                costoFijoController.text.replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0,
        margenGanancia: double.tryParse(
                margenController.text.replaceAll('%', '')) ??
            0.0,
      );

      Navigator.pushNamed(
        context,
        '/generar',
        arguments: negocio,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor completa todos los campos antes de continuar.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
      title: 'Datos Del Producto',
      showBack: true,
      showBottomBar: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Ingresa los materiales utilizados.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: size.width * 0.045),
            ),
            const SizedBox(height: 20),
            ...List.generate(materiales.length, construirMaterial),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  materiales.add({
                    'nombre': TextEditingController(),
                    'cantidad': TextEditingController(),
                    'costo': TextEditingController(),
                    'unidad': 'kg'
                  });
                });
              },
              icon: const Icon(Icons.add, color: Colors.black),
              label: Text('Agregar Material',
                  style: GoogleFonts.montserrat(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBDBA9),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Costos Fijos Mensuales',
                    style: GoogleFonts.montserrat()),
                IconButton(
                  icon: const Icon(Icons.info_outline,
                      size: 20, color: Colors.brown),
                  onPressed: mostrarInfoCostosFijos,
                ),
              ],
            ),
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
                  costoFijoController.text =
                      '\$${value.replaceAll('\$', '')}';
                  costoFijoController.selection =
                      TextSelection.fromPosition(
                    TextPosition(offset: costoFijoController.text.length),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Margen de ganancia deseado',
                    style: GoogleFonts.montserrat()),
                IconButton(
                  icon: const Icon(Icons.info_outline,
                      size: 20, color: Colors.brown),
                  onPressed: mostrarInfoMargen,
                ),
              ],
            ),
            TextField(
              controller: margenController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                hintText: '0.00%',
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (!value.endsWith('%')) {
                  margenController.text =
                      '${value.replaceAll('%', '')}%';
                  margenController.selection = TextSelection.fromPosition(
                    TextPosition(offset: margenController.text.length),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: validarYContinuar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBDBA9),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
              ),
              child: Text('Siguiente',
                  style: GoogleFonts.montserrat(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}