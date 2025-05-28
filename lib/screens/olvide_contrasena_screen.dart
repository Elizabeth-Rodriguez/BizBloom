import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class OlvideContrasenaScreen extends StatefulWidget {
  const OlvideContrasenaScreen({super.key});

  @override
  State<OlvideContrasenaScreen> createState() => _OlvideContrasenaScreenState();
}

class _OlvideContrasenaScreenState extends State<OlvideContrasenaScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo de recuperación enviado')),
      );

      Navigator.pop(context); // Volver al login
    } on FirebaseAuthException catch (e) {
      String message = 'Error al enviar el correo';
      if (e.code == 'user-not-found') {
        message = 'No se encontró una cuenta con ese correo.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ingresa tu correo registrado y te enviaremos un enlace para restablecer tu contraseña.',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                style: GoogleFonts.montserrat(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: GoogleFonts.montserrat(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color:Color(0xFF8B5E3C)),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa tu correo' : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEBDBA9),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: loading ? null : resetPassword,
                  child: loading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          'Enviar correo',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
