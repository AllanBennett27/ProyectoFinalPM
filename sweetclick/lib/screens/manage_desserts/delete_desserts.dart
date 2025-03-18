import 'package:flutter/material.dart';
import 'package:sweetclick/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteDesserts extends StatefulWidget {
  const DeleteDesserts({super.key});

  @override
  State<DeleteDesserts> createState() => _DeleteDessertsState();
}

class _DeleteDessertsState extends State<DeleteDesserts> {
  final CRUDBakery _crudBakery = CRUDBakery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: 
          Column(
            children: [
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
              
                        return SizedBox(
                          width: 50,
                          height: 150,
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
                                  
                                  
                                        TextButton(
                                          onPressed: () {
                                            CRUDBakery().deleteDessert(snapshot.data![index].id);
                                          },
                                          child: const Icon(Icons.delete),
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