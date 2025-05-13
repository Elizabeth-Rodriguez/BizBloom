import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';

class DatosNegocioScreen extends StatefulWidget {
  const DatosNegocioScreen({super.key});

  @override
  State<DatosNegocioScreen> createState() => _DatosNegocioScreenState();
}

class _DatosNegocioScreenState extends State<DatosNegocioScreen> {
  final TextEditingController nombreNegocioController = TextEditingController();
  final TextEditingController campoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController nombreProductoController =
      TextEditingController();

  void mostrarInfoCampo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Qué es el campo?'),
        content: const Text(
            'Se refiere al área económica o sector donde se desarrolla tu negocio, como panaderia, moda, tecnología, etc.'),
        actions: [
          TextButton(
            child: const Text('Entendido'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void continuar() {
    if (nombreNegocioController.text.isEmpty ||
        campoController.text.isEmpty ||
        descripcionController.text.isEmpty ||
        nombreProductoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/datos',
      arguments: {
        'nombreNegocio': nombreNegocioController.text,
        'campo': campoController.text,
        'descripcion': descripcionController.text,
        'nombreProducto': nombreProductoController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
        title: 'Datos del Negocio',
        showBack: true,
        showBottomBar: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100), // Ajusta el valor según lo necesites
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre del negocio',
                          style: GoogleFonts.montserrat()),
                      const SizedBox(height: 5),
                      TextField(
                        controller: nombreNegocioController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child:
                                Text('Campo', style: GoogleFonts.montserrat()),
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline,
                                size: 20, color: Colors.brown),
                            onPressed: mostrarInfoCampo,
                          )
                        ],
                      ),
                      TextField(
                        controller: campoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Descripción breve',
                          style: GoogleFonts.montserrat()),
                      const SizedBox(height: 5),
                      TextField(
                        controller: descripcionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Nombre del producto',
                          style: GoogleFonts.montserrat()),
                      const SizedBox(height: 5),
                      TextField(
                        controller: nombreProductoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: continuar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBDBA9),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                    ),
                    child: Text('Siguiente',
                        style: GoogleFonts.montserrat(color: Colors.black)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
