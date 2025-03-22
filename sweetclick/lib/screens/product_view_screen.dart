
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetclick/services/crud.dart';


class DessertDetailScreen extends StatefulWidget {
  final Map<String, dynamic> dessert;

  const DessertDetailScreen({Key? key, required this.dessert}) : super(key: key);

  @override
  _DessertDetailScreenState createState() => _DessertDetailScreenState();
}

class _DessertDetailScreenState extends State<DessertDetailScreen> {
  
  final CRUDBakery _crudBakery = CRUDBakery();

  @override
  Widget build(BuildContext context) {
    
    final userId = FirebaseAuth.instance.currentUser!.uid;
  

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dessert['name']),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(191, 82, 105, 1),
      ),
      body: Stack(
        children: [
         
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 
                    Image.network(
                      widget.dessert['imageUrl'],
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                  
                    Text(
                      widget.dessert['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                   
                    Text(
                      "Descripción de producto",
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.dessert['description'],
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                   
                    Text(
                      "Precio: Lps.${widget.dessert['price']}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                
                    Text(
                      "Tipo: ${widget.dessert['type']}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),

        
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                
                
                await _crudBakery.addToCart(
                  userId: userId,
                  dessertId: widget.dessert["id"], 
                  quantity: 1, 
                  price: widget.dessert['price'],
                  imageUrl: widget.dessert['imageUrl'],
                  name: widget.dessert['name'],
                );

               
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Postre agregado al carrito"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(191, 82, 105, 1),
                foregroundColor: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

