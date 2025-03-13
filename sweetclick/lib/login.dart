import 'package:flutter/material.dart';
import 'register.dart'; 

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Image.asset('assets/logo.png', width: 250), // Tu logo
            SizedBox(height: 20),

            Divider(
              color: const Color.fromARGB(255, 255, 255, 255),
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),

            SizedBox(height: 20),

            Text(
              "Inicia sesión",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // Campos de entrada
            CustomTextField(icon: Icons.email, hintText: "Correo electrónico"),
            CustomTextField(icon: Icons.lock, hintText: "Contraseña", isPassword: true),

            SizedBox(height: 15),

            // Botón de iniciar sesión
            ElevatedButton(
              onPressed: () {
                // Aquí iría la lógica para iniciar sesión
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(191, 82, 105, 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: Text("Iniciar sesión", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            SizedBox(height: 10),

            // Texto de registro con navegación a la pantalla de registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()), // Navega a la pantalla de registro
                );
              },
              child: Text(
                "¿No tienes cuenta? Regístrate",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget personalizado para los campos de texto
class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;

  const CustomTextField({
    required this.icon,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(191, 82, 105, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
