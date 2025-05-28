import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_screen.dart';
import '../widgets/negocio_card.dart';
import '../helpers/db_helper.dart';
import '../models/negocio.dart';
import 'package:firebase_auth/firebase_auth.dart';       // MODIFICADO
import 'package:google_sign_in/google_sign_in.dart';

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

  void _confirmarCierreSesion(BuildContext context) async {
  final confirmacion = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Cerrar sesión',
      style: TextStyle(color: Colors.brown),
      ),
      content: const Text(
        '¿Estás seguro de que deseas cerrar sesión?',
        style: TextStyle(color: Colors.black),
        ),
      actions: [
        TextButton(
          child: const Text('Cancelar',
          style: TextStyle(color: Colors.brown),
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Cerrar sesión',
          style: TextStyle(color: Colors.brown),
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );

  if (confirmacion == true) {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}

  @override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return BaseScreen(
    title: 'Inicio',
    showBack: false,
    showBottomBar: true,
    actions: [
    IconButton(
      icon: const Icon(Icons.logout, color: Colors.black),
      onPressed: () => _confirmarCierreSesion(context), // función que definiremos abajo
    ),
  ],
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

