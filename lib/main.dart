import 'screens/generar_screen.dart';
import 'screens/informe_screen.dart';
import 'package:bizbloom/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/negocio.dart';

// Importa tus pantallas
import 'screens/bienvenida_screen.dart';
import 'screens/inicio_screen.dart';
import 'screens/logro_screen.dart';
import 'screens/intento_screen.dart';
import 'screens/motivo_screen.dart';
import 'screens/hablemos_screen.dart';
import 'screens/datos_negocio_screen.dart';
import 'screens/datos_producto_screen.dart';
import 'screens/calculadora_screen.dart';

Future<Map<String, dynamic>> loadConfig() async {
  try {
    final configString = await rootBundle.loadString('assets/env.json');
    final config = json.decode(configString);
    print('API_KEY: ${config['API_KEY']}');
    print('BASE_URL: ${config['BASE_URL']}');
    return config;
  } catch (e) {
    print('Error cargando env.json: $e');
    return {};
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  runApp(const BizBloomApp());
}

class BizBloomApp extends StatelessWidget {
  const BizBloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizBloom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BienvenidaScreen(),
        '/inicio': (context) => const InicioScreen(),
        '/calcu': (context) => const CalculadoraScreen(),
        '/logro': (context) => const LogroScreen(),
        '/intento': (context) => const IntentoScreen(),
        '/motivo': (context) => const MotivoScreen(),
        '/hablemos': (context) => const HablemosScreen(),
        '/datos': (context) => const DatosProductoScreen(),
        '/datos-negocio': (context) => const DatosNegocioScreen(),
        '/login': (context) => const LoginScreen(),
        
        // Aquí se pasa el argumento 'negocio' al GenerarScreen
        '/generar': (context) {
          final negocio = ModalRoute.of(context)!.settings.arguments as Negocio?;
          if (negocio != null) {
            return GenerarScreen(negocio: negocio);
          } else {
            // Si no se pasa el objeto Negocio, puedes manejar el error o redirigir
            return const BienvenidaScreen(); // Redirigir a pantalla inicial o de error
          }
        },
      },
    );
  }
}
