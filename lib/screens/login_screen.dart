import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? 'Iniciar Sesión' : 'Registrarse',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              labelStyle: GoogleFonts.montserrat(),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Ingresa tu correo' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: GoogleFonts.montserrat(),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Ingresa tu contraseña' : null,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isLogin
                                          ? 'Iniciando sesión...'
                                          : 'Registrando cuenta...',
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ),
                                );
                                Navigator.pushReplacementNamed(
                                    context, '/inicio');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEBDBA9),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              isLogin ? 'Entrar' : 'Registrarse',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: toggleForm,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            child: Text(
                              isLogin
                                  ? '¿No tienes cuenta? Regístrate'
                                  : '¿Ya tienes cuenta? Inicia sesión',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}