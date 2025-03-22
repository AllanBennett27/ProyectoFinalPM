import 'package:flutter/material.dart';

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
                        colors: [Color.fromRGBO(191, 82, 105, 1).withOpacity(0.7), Color.fromRGBO(191, 82, 105, 1).withOpacity(0.7)],
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
          Icon(Icons.favorite, color: Color.fromRGBO(191, 82, 105, 1), size: 50),
          SizedBox(height: 10),
          Text(
            'Su pago ha sido efectuado\nexitosamente.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          BottomNavigationBar(
            backgroundColor: Color.fromRGBO(191, 82, 105, 1),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.white), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white), label: ''),
            ],
          ),
        ],
      ),
    );
  }
}
