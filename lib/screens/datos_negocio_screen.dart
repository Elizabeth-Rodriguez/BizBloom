import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';
import '../models/negocio.dart';
import '../helpers/db_helper.dart';

class DatosNegocioScreen extends StatefulWidget {
  const DatosNegocioScreen({super.key});

  @override
  State<DatosNegocioScreen> createState() => _DatosNegocioScreenState();
}

class _DatosNegocioScreenState extends State<DatosNegocioScreen> {
  final TextEditingController nombreNegocioController = TextEditingController();
  final TextEditingController campoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController nombreProductoController = TextEditingController();

 void mostrarInfoCampo() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white, 
      title: const Text(
        '¿Qué es el campo?',
        style: TextStyle(color: Color(0xFF795548)),
      ),
      content: const Text(
        'Se refiere al área económica o sector donde se desarrolla tu negocio, como panadería, moda, tecnología, etc.',
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
    return BaseScreen(
      title: 'Datos del Negocio',
      showBack: true,
      showBottomBar: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    campoTexto('Nombre del negocio', nombreNegocioController),
                    campoConInfo('Campo', campoController, mostrarInfoCampo),
                    campoTexto('Descripción breve', descripcionController, maxLines: 3),
                    campoTexto('Nombre del producto', nombreProductoController),
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: Text('Siguiente', style: GoogleFonts.montserrat(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

Widget campoTexto(String label, TextEditingController controller, {int maxLines = 1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat()),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16), 
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF8B5E3C), width: 2),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget campoConInfo(String label, TextEditingController controller, VoidCallback onInfoTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: GoogleFonts.montserrat())),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.brown),
              onPressed: onInfoTap,
            ),
          ],
        ),
        TextField(
          controller: controller,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.brown, width: 2),
            ),
          ),
        ),
      ],
    ),
  );
}

}
