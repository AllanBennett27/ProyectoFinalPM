import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/authentication/register.dart';
import 'package:sweetclick/screens/initial_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para capturar la información ingresada

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // Función para guardar la información
  Future<void> loginUserwithEmailAndPassword() async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print(UserCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                  height: 250,
                  width: 250,
                  alignment: Alignment.center,
                  child: Image.asset('assets/logo.png', fit: BoxFit.cover)),
              SizedBox(height: 20),

              Divider(
                color: Colors.white,
                thickness: 5,
                indent: 40,
                endIndent: 40,
              ),

              SizedBox(height: 10),

              Text(
                "Iniciar sesion",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),

              // Campos de entrada

              CustomTextField(
                  icon: Icons.email,
                  hintText: "Correo electrónico",
                  controller: _emailController),

              CustomTextField(
                  icon: Icons.lock,
                  hintText: "Contraseña",
                  isPassword: true,
                  controller: _passwordController),

              SizedBox(height: 15),

              // Botón de Crear cuenta
              ElevatedButton(
                onPressed: () async {
                  await loginUserwithEmailAndPassword();
                  final user = FirebaseAuth.instance.currentUser;
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  if (user != null && email.isNotEmpty && password.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => InitialScreen(
                                initialValue: user.displayName ?? "Usuario",
                                PfpValue: user.photoURL ??
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqVg_URh9Mvrm3NYaTlCUyiM7r382ohELc1g&s",
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC25668),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: Text("Inicia sesion",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              SizedBox(height: 10),

              // Botón de Cancelar
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            RegisterScreen()), // Navega a la pantalla de registro
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
      ),
    );
  }
}

// Widget personalizado para los campos de texto
class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    required this.icon,
    required this.hintText,
    required this.controller,
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
              controller: controller,
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
