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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                dessert['imageUrl'],
                
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                dessert['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Descripcion de producto",   style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,),
              Text(
                dessert['description'],
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "\$${dessert['price']}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 30,),
               Row(
                 children: [
                   ElevatedButton(
                    onPressed: () {
                      print("Added cart");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, 
                      foregroundColor: Colors.white, 
                      iconColor: Colors.black,
                      elevation: 5,
                      padding: EdgeInsets.all(20), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                      ),
                    ),
                    
                    child: Icon(Icons.shopping_cart),
                   ),
                  
                 ],
               ),
            ],
          ),
        ),
      ),
    );
  }
}
