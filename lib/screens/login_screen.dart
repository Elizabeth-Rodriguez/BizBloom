import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/inicio');
      });
    }
  }

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  Future<void> signInWithEmail() async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      }

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/inicio');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No existe una cuenta con este correo. Regístrate primero.';
          break;
        case 'wrong-password':
          message = 'La contraseña es incorrecta. Inténtalo de nuevo.';
          break;
        case 'email-already-in-use':
          message = 'Este correo ya está registrado.';
          break;
        case 'invalid-email':
          message = 'El correo ingresado no es válido.';
          break;
        case 'weak-password':
          message = 'La contraseña es muy débil. Usa al menos 6 caracteres.';
          break;
        case 'too-many-requests':
          message = 'Demasiados intentos. Intenta más tarde.';
          break;
        default:
          message = 'Ocurrió un error al autenticar. Verifica tus datos e intenta de nuevo.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ocurrió un error. Inténtalo más tarde.')),
      );
    }
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.montserrat(
        color: const Color(0xFF8B5E3C),
      ),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8B5E3C), width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
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
                            decoration: buildInputDecoration('Correo electrónico'),
                            validator: (value) =>
                                value!.isEmpty ? 'Ingresa tu correo' : null,
                                cursorColor: Colors.black,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            decoration: buildInputDecoration('Contraseña').copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: const Color(0xFF8B5E3C),
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Ingresa tu contraseña' : null,
                          ),

                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signInWithEmail();
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
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          if (isLogin)
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/olvide');
                              },
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 110, 76, 43),
                                ),
                              ),
                            ),
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
