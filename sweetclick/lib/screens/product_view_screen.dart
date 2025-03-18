import 'package:flutter/material.dart';

class ProductViewScreen extends StatelessWidget {
  final Map<String, dynamic> dessert;

  const ProductViewScreen({super.key, required this.dessert});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dessert['name']),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Stack(
        children: [
          // Contenido desplazable
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Imagen del postre
                    Image.network(
                      dessert['imageUrl'],
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    // Nombre del postre
                    Text(
                      dessert['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Descripción del postre
                    Text(
                      "Descripción de producto",
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dessert['description'],
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    // Precio del postre
                    Text(
                      "Precio: Lps.${dessert['price']}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Tipo de postre
                    Text(
                      "Tipo: ${dessert['type']}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 80), 
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () {
                print("Added to cart");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                iconColor: Colors.black,
                elevation: 5,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
    );
  }
}