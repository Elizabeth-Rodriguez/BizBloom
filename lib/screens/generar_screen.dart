import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/negocio.dart';
import '../helpers/db_helper.dart';
import '/screens/informe_screen.dart';

class GenerarScreen extends StatelessWidget {
  final Negocio negocio;

  const GenerarScreen({super.key, required this.negocio});

  Future<void> _guardarNegocio(BuildContext context) async {
    // Guardar negocio en la base de datos usando DBHelper
    int id = await DBHelper().insertarNegocio(negocio);
    print("Negocio guardado con ID: $id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Perfecto!',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Podemos ayudarte con los\nprimeros pasos.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                const SizedBox(height: 24),
                Text(
                  '¿Listo para tu informe?',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    await _guardarNegocio(context);  // Guardar negocio antes de navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformeScreen(negocio: negocio),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEBDBA9),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Generar',
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
