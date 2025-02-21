import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png', // Asegúrate de tener la imagen en assets/logo.png
                height: 350,
              ),

              const SizedBox(height: 40),

              // Botón de Registro con Correo
              ElevatedButton.icon(
                onPressed: () {
                  // Aquí va la lógica de registro
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(191, 82, 105, 1), // Rosita
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'Registro con correo electrónico',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              const SizedBox(height: 30),

              // Texto "Crear nueva cuenta"
              const Text(
                'Crear nueva cuenta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // 🔗 Enlace "¿Ya tienes cuenta? Inicia sesión"
              GestureDetector(
                onTap: () {
                  // Navegar al login
                },
                child: const Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
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
