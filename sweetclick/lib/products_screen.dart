import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Raspberry Cheesecake",
      "price": "L140.00",
      "image": "assets/cheesecake.png"
    },
    {
      "name": "Pastel de chocolate",
      "price": "L140.00",
      "image": "assets/chocolate_cake.png"
    },
    {
      "name": "Tres leches cake",
      "price": "L140.00",
      "image": "assets/tres_leches.png"
    },
    {
      "name": "Selva negra cake",
      "price": "L140.00",
      "image": "assets/selva_negra.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("¿Qué se te antoja hoy?"),
        backgroundColor: Color(0xFFC25668),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: "Search food that you like...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            // GridView para mostrar los productos
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columnas
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: products[index]["name"],
                    price: products[index]["price"],
                    image: products[index]["image"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFC25668),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

// Widget para cada tarjeta de producto
class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductCard({required this.name, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(price, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    // Aquí iría la navegación a la pantalla de personalización
                  },
                  child: Text("Click para personalizar", style: TextStyle(color: Colors.pinkAccent)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
