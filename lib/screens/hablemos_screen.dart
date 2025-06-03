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
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
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
                style: GoogleFonts.montserrat(
                  fontSize: size.width * 0.04,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Imagen debajo del texto
              Image.asset(
                'assets/images/graphic.png', 
                width: size.width * 0.7,
                height: size.height * 0.25,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/datos-negocio');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBDBA9),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Continuar',
                  style: GoogleFonts.montserrat(
                    fontSize: size.width * 0.045,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
          ),
    );
  }
}

