import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';

class HablemosScreen extends StatelessWidget {
  const HablemosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
      title: '',
      showBack: false,
      showBottomBar: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hablemos de tu negocio',
            style: GoogleFonts.montserrat(
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Es hora de hablar de costos y ganancias, esta información nos ayudará a realizar tu informe',
            style: GoogleFonts.montserrat(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/datos-negocio');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBDBA9),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Continuar',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
