// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/screens/product_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetclick/services/crud.dart';

// ignore: camel_case_types
class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<Home_screen> {
  final CRUDBakery _crudBakery = CRUDBakery();
    final SearchController _searchController = SearchController();

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
                    repeat: ImageRepeat.repeat,
                  ),
                  const Center(
                    child: Text(
                      "¿Que se antoja hoy?",
                      style: TextStyle(
                        backgroundColor: Colors.pink,
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
          Center(
            child: SearchAnchor(
              searchController: _searchController,
              builder: (BuildContext context, SearchController controller) {
                return Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: SearchBar(
                    controller: _searchController,
                    onTap: () {
                      _searchController.openView();
                    },
                    onChanged: (_) {
                      _searchController.openView();
                    },
                    leading: const Icon(Icons.search),
                  ),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                final List<String> items = [
                   'Tortas',
                    'Postres fríos',
                    'Postres calientes',
                    'Galletas y brownies',
                    'Helados',
                    'Otros',
                ];

                return List<ListTile>.generate(items.length, (int index) {
                  final String item = items[index];
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        _searchController.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
          ),




          const SizedBox(height: 10),
          StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _crudBakery.getDesserts(), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No data here"),
                );
              }

              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var dessert = snapshot.data![index].data();
                   
                    if(_searchController.text.isEmpty || _searchController.text == dessert["type"].toString()){
                    return SizedBox(
                      width: 50,
                      height: 150,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DessertDetailScreen(dessert: dessert,),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                dessert['imageUrl'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              ListTile(
                                title: Text(dessert['name']),
                                subtitle: Text(
                                  '${dessert['type']}\n Lps.${dessert['price']}',
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                      ),
                    );
                    }
                    else {
                      return const SizedBox.shrink(); 
                    }
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