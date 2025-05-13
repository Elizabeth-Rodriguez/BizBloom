import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';

class MotivoScreen extends StatefulWidget {
  const MotivoScreen({super.key});

  @override
  State<MotivoScreen> createState() => _MotivoScreenState();
}

class _MotivoScreenState extends State<MotivoScreen> {
  final List<String> opciones = [
    'El deseo de aprender',
    'El exito y el reconocimiento',
    'El innovar'
  ];
  String? opcionSeleccionada;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScreen(
      title: '¿Que te motiva?',
      showBack: true,
      showBottomBar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Selecciona uno de los siguientes objetivos:',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: size.width * 0.045,
            ),
          ),
          const SizedBox(height: 20),

          // Opciones del formulario
          ...opciones.map((opcion) {
            final bool esSeleccionada = opcion == opcionSeleccionada;

            return GestureDetector(
              onTap: () {
                setState(() {
                  opcionSeleccionada = opcion;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color:
                      esSeleccionada ? const Color(0xffefca92) : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    opcion,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 30),

          // Botón de Siguiente
          ElevatedButton(
            onPressed: opcionSeleccionada == null
                ? null
                : () {
                    // Aquí puedes poner tu ruta deseada, por ejemplo:
                    Navigator.pushNamed(context, '/hablemos');
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEBDBA9),
              disabledBackgroundColor: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Siguiente',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
