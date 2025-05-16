import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
        title: 'Inicio',
        showBack: false,
        showBottomBar: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Encamina tu\nnegocio',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/logro'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBDBA9),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.folder_open, color: Colors.black),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Calcular Nuevo Negocio',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              Text(
                'Historial de negocios',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Temporal: Mensaje si no hay historial
              Text(
                'No se encontraron negocios',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }
}
