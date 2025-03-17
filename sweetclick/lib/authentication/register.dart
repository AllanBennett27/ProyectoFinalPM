import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/authentication/login.dart';

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

  


  Future<void> createUserwithEmailandPassword() async{
    try{
        final UserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
      
   
      );

       if (UserCredential.user != null) {
      await UserCredential.user!.updateDisplayName(_nameController.text.trim());
      await UserCredential.user!.reload(); // Recargar usuario para aplicar cambios
      print("Usuario creado: ${UserCredential.user!.displayName}");
    }
      
    
        print(UserCredential.user?.uid);


    }//try 
    on FirebaseAuthException catch (e){
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
            
              Image.asset('assets/logo.png', width: 250, height: 250,),
             
        
              Divider(
        color: Colors.white,
        thickness: 5,  
        indent: 40,    
        endIndent: 40, 
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
                onPressed: ()async{
                  await createUserwithEmailandPassword();
                } ,
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
                 Navigator.push(context,MaterialPageRoute(builder: (_)=>LoginScreen()));// Regresar a la pantalla anterior
                },
                child: Text("Cancelar", style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
              SizedBox(height: 30),
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
    this.isPassword = false, 
    required this.controller,
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

