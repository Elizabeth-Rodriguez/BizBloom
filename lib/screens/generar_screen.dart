import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/informe_screen.dart';
import '/models/negocio.dart';

class GenerarScreen extends StatelessWidget {
  final Negocio negocio;

  const GenerarScreen({super.key, required this.negocio});

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
                  onPressed: () {
                    // Navegar a InformeScreen y pasar el negocio
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformeScreen(negocio: negocio),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEAD69E),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
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
