import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/firebase_options.dart';
import 'package:sweetclick/login.dart';
import 'package:sweetclick/register.dart';
import 'dart:async';
//import 'package:sweetclick/login.dart';

import 'package:sweetclick/screens/initial_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen()
      //  InitialScreen(initialValue: "Nombre de usuario",),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Aquí iría la navegación a la pantalla principal
     Navigator.pushReplacement(context, 
     MaterialPageRoute(
      builder: (_) 
      => 
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting ){
            return Center(
            child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data != null){
            final user = snapshot.data as User;
            
             return InitialScreen(initialValue: user.displayName ?? "Nombre de usuario");
          }
          return LoginScreen();
        }
      )
      
      
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: Center(
        child: Image.asset('assets/logo.png', width: 350), 
      ),
    );
  }
}
