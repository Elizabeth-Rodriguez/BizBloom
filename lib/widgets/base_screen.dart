import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBack;
  final bool showBottomBar;
  final bool showSkip; // Nueva propiedad para el botón "Omitir"

  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.showBack = false,
    this.showBottomBar = false,
    this.showSkip = false, // Valor por defecto: no se muestra
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: showSkip
            ? [
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.black),
                  onPressed: () {
                    // Define aquí la acción cuando el usuario presione "Omitir"
                    Navigator.pushNamed(context,'/hablemos');
                  },
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
      bottomNavigationBar: showBottomBar
          ? BottomAppBar(
              color: Colors.white,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.black),
                    onPressed: () => Navigator.pushNamed(context, '/inicio'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calculate, color: Colors.black),
                    onPressed: () => Navigator.pushNamed(context, '/calcu'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}