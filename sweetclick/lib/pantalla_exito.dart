import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/screens/initial_screen.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset('assets/cheesecake.png', fit: BoxFit.cover),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(191, 82, 105, 1).withOpacity(0.7),
                          Color.fromRGBO(191, 82, 105, 1).withOpacity(0.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      '¡Éxito!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Icon(Icons.favorite,
              color: Color.fromRGBO(191, 82, 105, 1), size: 50),
          SizedBox(height: 10),
          Text(
            'Su pago ha sido efectuado\nexitosamente.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => InitialScreen(
                            initialValue: user?.displayName ?? "Usuario",
                            PfpValue: user?.photoURL ??
                                "https://www.webiconio.com/_upload/255/image_255.svg",
                          )));
            },
          ),
        ],
      ),
    );
  }
}
