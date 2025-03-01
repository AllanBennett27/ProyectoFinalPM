import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores para capturar la información ingresada
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para guardar la información
  void _saveData() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && password.isNotEmpty) {
      print("✅ Cuenta creada con éxito");
      print("Nombre: $name");
      print("Correo: $email");
      print("Teléfono: $phone");
      print("Contraseña: $password");
      
      // Aquí podrías enviar los datos a una base de datos o backend

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cuenta creada con éxito')),
      );

      // Opcional: Redirigir a la pantalla de login o inicio
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

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
            Image.asset('assets/logo.png', width: 350),
            SizedBox(height: 20),

            Divider(
      color: Colors.white,
      thickness: 5,  // Grosor de la línea
      indent: 40,    // Espaciado desde los lados
      endIndent: 40, // Espaciado desde los lados
    ),
    
    SizedBox(height: 20), // Espacio entre la línea y el título

            Text(
              "Crear nueva cuenta",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // Campos de entrada
            CustomTextField(icon: Icons.person, hintText: "Nombre Completo", controller: _nameController),
            CustomTextField(icon: Icons.email, hintText: "Correo electrónico", controller: _emailController),
            CustomTextField(icon: Icons.phone, hintText: "Número de celular", controller: _phoneController),
            CustomTextField(icon: Icons.lock, hintText: "Contraseña", isPassword: true, controller: _passwordController),

            SizedBox(height: 15),

            // Botón de Crear cuenta
            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC25668),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: Text("Crear cuenta", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            SizedBox(height: 10),

            // Botón de Cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: Text("Cancelar", style: TextStyle(color: Colors.black, fontSize: 16)),
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
