import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';

class HablemosScreen extends StatelessWidget {
  const HablemosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
      title: 'Hablemos',
      showBack: false,
      showBottomBar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '¡Gracias por compartir tu visión!',
            style: GoogleFonts.montserrat(
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tu negocio tiene potencial y estás dando pasos importantes para llevarlo al siguiente nivel. 💡',
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Text(
            'Recomendaciones generales:',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...[
            '📈 Evalúa regularmente tus costos y márgenes.',
            '🎯 Establece metas trimestrales claras.',
            '📊 Utiliza herramientas de proyección para planificar tu crecimiento.',
            '🤝 Busca redes de apoyo o mentoría emprendedora.',
          ].map(
            (reco) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                reco,
                style: GoogleFonts.montserrat(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/datos-negocio',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBCA177),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
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
