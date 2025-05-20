import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';
import '../widgets/negocio_card.dart';
import '../helpers/db_helper.dart';
import '../models/negocio.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final DBHelper _dbHelper = DBHelper();
  late Future<List<Negocio>> _futureNegocios;

  @override
  void initState() {
    super.initState();
    _futureNegocios = _dbHelper.obtenerNegocios();
  }

  Future<void> _refrescarNegocios() async {
    setState(() {
      _futureNegocios = _dbHelper.obtenerNegocios();
    });
  }

  @override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return BaseScreen(
    title: 'Inicio',
    showBack: false,
    showBottomBar: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.1),
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
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/logro');
            if (result == true) {
              setState(() {
                _futureNegocios = _dbHelper.obtenerNegocios();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEBDBA9),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        Expanded(
          child: FutureBuilder<List<Negocio>>(
            future: _futureNegocios,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No se encontraron negocios',
                    style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey),
                  ),
                );
              } else {
                final negociosGuardados = snapshot.data!;
                return RefreshIndicator(
  onRefresh: _refrescarNegocios,
  backgroundColor: Colors.black, 
  color: Colors.white, 
  child: ListView.builder(
    itemCount: negociosGuardados.length,
    itemBuilder: (context, index) {
      final negocio = negociosGuardados[index];
      return NegocioCard(
        negocio: negocio,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/detalleNegocio',
            arguments: negocio,
          );
        },
      );
    },
  ),
);

              }
            },
          ),
        ),
      ],
    ),
  );
}

}



/*import 'package:flutter/material.dart';
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
*/