import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBack;
  final bool showBottomBar;
  final bool showSkip; // Botón "Omitir"
  final List<Widget>? actions;

  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.showBack = false,
    this.showBottomBar = false,
    this.showSkip = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          title,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: actions ??
    (showSkip
        ? [
            IconButton(
              icon: const Icon(Icons.skip_next, color: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, '/hablemos');
              },
            ),
          ]
        : null),

      ),

      body: SafeArea(
        child: Padding(
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

