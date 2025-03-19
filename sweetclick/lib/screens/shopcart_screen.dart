import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetclick/services/crud.dart';

class ShopcartScreen extends StatefulWidget {
  const ShopcartScreen({super.key});

  @override
  State<ShopcartScreen> createState() => _ShopcartScreenState();
}

class _ShopcartScreenState extends State<ShopcartScreen> {
  final CRUDBakery _crudBakery = CRUDBakery();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrito de Compras"),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _crudBakery.getCart(user), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("Tu carrito está vacío"),
            );
          }

          final cartData = snapshot.data!.data();
          if (cartData == null) {
            return const Center(
              child: Text("Error al cargar el carrito"),
            );
          }

          final List<dynamic> items = cartData["items"] ?? [];
          final double totalCarrito = cartData["total"] ?? 0.0; 
          return Column(
            children: [
             
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index] as Map<String, dynamic>?;
                    if (item == null) {
                      return const Center(child: Text("Producto no disponible"));
                    }

                    final name = item["name"] as String? ?? "Nombre no disponible";
                    final price = item["price"] as double? ?? 0.0;
                    final imageUrl = item["imageUrl"] as String?;
                    final quantity = item["quantity"] as int? ?? 0;
                    final dessertId = item["dessertId"] as String?;

                    
                    final totalPorProducto = quantity * price;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (imageUrl != null)
                            Image.network(
                              imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          else
                            const Icon(Icons.image, size: 100), 

                          ListTile(
                            title: Text(name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cantidad: $quantity'),
                                Text('Precio unitario: Lps.${price.toStringAsFixed(2)}'),
                                Text('Total: Lps.${totalPorProducto.toStringAsFixed(2)}'), 
                              ],
                            ),
                          ),
                       
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () async {
                                  if (dessertId != null && quantity > 1) {
                                    await _crudBakery.addToCart(
                                      userId: user,
                                      dessertId: dessertId,
                                      quantity: -1, 
                                      name: name,
                                      price: price,
                                      imageUrl: imageUrl ?? "",
                                    );
                                  }
                                },
                              ),
                              
                              Text("$quantity"),
                             
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () async {
                                  if (dessertId != null) {
                                    await _crudBakery.addToCart(
                                      userId: user,
                                      dessertId: dessertId,
                                      quantity: 1, 
                                      name: name,
                                      price: price,
                                      imageUrl: imageUrl ?? "",
                                    );
                                  }
                                },
                              ),

                               IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  if(dessertId != null){
                                  await _crudBakery.removeFromCart(userId: user, dessertId: dessertId);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
           
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Total del carrito: Lps.${totalCarrito.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 180,),
                     IconButton(
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () async {
                                  await _crudBakery.clearCart(user);
                                },
                              ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}