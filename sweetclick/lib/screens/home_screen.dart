

import 'package:flutter/material.dart';
import 'package:sweetclick/screens/product_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetclick/services/crud.dart';


// ignore: camel_case_types
class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  final CRUDBakery _crudBakery = CRUDBakery();
  final TextEditingController _searchController = TextEditingController();
  String _currentSearchTerm = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: [
       
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 300,
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                    "https://media.tenor.com/CgRQNtNwE-oAAAAM/desserts-food.gif",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const Center(
                    child: Text(
                      "¿Que se antoja hoy?",
                      style: TextStyle(
                        backgroundColor: Color.fromRGBO(191, 82, 105, 1),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar postres...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _currentSearchTerm = "";
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _currentSearchTerm = value.toLowerCase();
                });
              },
            ),
          ),
          
          const SizedBox(height: 10),
          
          
          StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _crudBakery.getDesserts(), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("No hay productos disponibles"),
                  ),
                );
              }
              
              final filteredDesserts = snapshot.data!.where((doc) {
                final dessert = doc.data();
                return _currentSearchTerm.isEmpty ||
                    dessert['name'].toString().toLowerCase().contains(_currentSearchTerm) ||
                    dessert['type'].toString().toLowerCase().contains(_currentSearchTerm);
              }).toList();
              
              if (filteredDesserts.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("No se encontraron resultados"),
                  ),
                );
              }
              
              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: filteredDesserts.length,
                  itemBuilder: (context, index) {
                    final dessert = filteredDesserts[index].data();
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DessertDetailScreen(dessert: dessert),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.all(4),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  dessert['imageUrl'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => 
                                    const Icon(Icons.broken_image, size: 50),
                                  loadingBuilder: (context, child, loadingProgress) =>
                                    loadingProgress == null ? child : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      dessert['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${dessert['type']}\nLps. ${dessert['price']}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}